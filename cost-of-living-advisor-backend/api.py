from flask import Flask, request, jsonify
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from flask_cors import CORS, cross_origin
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text, create_engine
from sqlalchemy.exc import SQLAlchemyError
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import timedelta
import os
import mysql.connector
from mysql.connector import Error

from classes_for_llm.Root import RootLLM
from classes_for_llm.UserPreferencesManager import UserPreferencesManager
from classes_for_llm.calculations import calculate_average_price_for_electricity,calculate_average_price_for_water,calculate_average_price_for_natural_gas
app = Flask(__name__)

app.config[
    'SECRET_KEY'] = 'Bj7qxGUEPQvTUpee9DqFltEqlPvEIod1yK6Pr89qFxJJtFfZKNXnhuARVgYIfoCM8ax0Db4D2LIZtxxbkrM1HZkmGZh5OUC3j6HtxgVIZiud3fifcOSa/xJZ5VNePG2VA/mWELM5XTtLi5C8Yfv3ex2QN5Hu0E8k7lY9sTHo1N4='

# Database configuration
DB_HOST = 'localhost'
DB_PORT = 3306
DB_USER = 'root'
DB_PASSWORD = 'rootpassword'
DB_NAME = 'user_details_and_preferences'


# Function to create database if it doesn't exist
def create_database_if_not_exists():
    try:
        # Connect to MySQL server without specifying database
        connection = mysql.connector.connect(
            host=DB_HOST,
            port=DB_PORT,
            user=DB_USER,
            password=DB_PASSWORD
        )

        if connection.is_connected():
            cursor = connection.cursor()

            # Create database if it doesn't exist
            cursor.execute(f"CREATE DATABASE IF NOT EXISTS {DB_NAME}")
            print(f"Database '{DB_NAME}' created successfully or already exists.")

            cursor.close()
            connection.close()

    except Error as e:
        print(f"Error while connecting to MySQL: {e}")
        raise e


# Create database before setting up SQLAlchemy
create_database_if_not_exists()

# MySQL Database Configuration
app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+mysqlconnector://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_IDENTITY_CLAIM'] = 'sub'
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(hours=24)

db = SQLAlchemy(app)
jwt = JWTManager(app)


CORS(app,
     origins=["http://localhost:4200", "http://127.0.0.1:4200"],
     methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
     allow_headers=["Content-Type", "Authorization"],
     supports_credentials=True,
     expose_headers=["Content-Type", "Authorization"])


class User(db.Model):
    __tablename__ = 'users'  # Explicit table name

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password_hash = db.Column(db.String(256), nullable=False)

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)


class UserPreferences(db.Model):
    __tablename__ = 'user_preferences'  # Explicit table name

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    user = db.relationship('User', backref='preferences')

    # Current Location
    current_city = db.Column(db.String(100), nullable=False)
    current_district = db.Column(db.String(100), nullable=False)

    # Target Location
    target_city = db.Column(db.String(100), nullable=False)
    target_district = db.Column(db.String(100), nullable=False)

    # Personal Details
    age = db.Column(db.Integer, nullable=False)
    family_size = db.Column(db.Integer, nullable=False)
    monthly_net_income = db.Column(db.Float, nullable=False)

    # Current Expenses - Housing
    monthly_rent = db.Column(db.Float, nullable=False)
    electricity_bill = db.Column(db.Float, nullable=False)
    natural_gas_bill = db.Column(db.Float, nullable=False)
    water_bill = db.Column(db.Float, nullable=False)
    internet_bill = db.Column(db.Float, nullable=False)

    # Transportation
    uses_public_transportation = db.Column(db.Boolean, default=False)
    is_the_user_student = db.Column(db.Boolean, default=False)
    public_transport_monthly_pass = db.Column(db.Float, nullable=True)

    # Education
    wants_education_analysis = db.Column(db.Boolean, default=False)
    target_university = db.Column(db.String(200), nullable=True)
    department_name = db.Column(db.String(200), nullable=True)
    current_tuition_semester = db.Column(db.Float, nullable=True)

    # Other Expenses
    gym_membership = db.Column(db.Float, nullable=True)
    entertainment_monthly = db.Column(db.Float, nullable=True)
    clothing_monthly = db.Column(db.Float, nullable=True)
    healthcare_monthly = db.Column(db.Float, nullable=True)
    subscriptions_monthly = db.Column(db.Float, nullable=True)
    travel_vacation_monthly = db.Column(db.Float, nullable=True)

    # Housing Preferences
    preferred_housing_type = db.Column(db.String(50), nullable=False)
    number_of_rooms = db.Column(db.String(20), nullable=False)

    # Vehicle Information
    owns_vehicle = db.Column(db.Boolean, default=False)
    vehicle_type = db.Column(db.String(50), nullable=True)
    fuel_tank_capacity = db.Column(db.Integer, nullable=True)
    fuel_tank_monthly_fill_count = db.Column(db.Integer, nullable=True)
    distributor_preference = db.Column(db.String(100), nullable=True)
    vehicle_fuel_type = db.Column(db.String(50), nullable=True)

    # Shopping Preferences
    grocery_preferences = db.Column(db.JSON, nullable=True)  # Store the grocery list as a simple array


# Function to initialize database tables
def initialize_database():
    """Create all database tables if they don't exist"""
    try:
        with app.app_context():
            db.create_all()
            print("Database tables created successfully!")
    except Exception as e:
        print(f"Error creating database tables: {e}")
        raise e


# Initialize database tables immediately after models are defined
initialize_database()


# Handle preflight requests explicitly
@app.before_request
def handle_preflight():
    if request.method == "OPTIONS":
        response = jsonify({'status': 'OK'})
        response.headers.add("Access-Control-Allow-Origin", request.headers.get('Origin', '*'))
        response.headers.add('Access-Control-Allow-Headers', "Content-Type,Authorization")
        response.headers.add('Access-Control-Allow-Methods', "GET,PUT,POST,DELETE,OPTIONS")
        response.headers.add('Access-Control-Allow-Credentials', 'true')
        return response

@app.route('/api/signup', methods=['POST'])
def signup():
    data = request.get_json()


    if User.query.filter_by(username=data['username']).first() or User.query.filter_by(email=data['email']).first():
        return jsonify({"msg": "Username or email already exists"}), 409

    user = User(username=data['username'], email=data['email'])
    user.set_password(data['password'])
    db.session.add(user)
    db.session.commit()

    access_token = create_access_token(identity=str(user.id))
    return jsonify({"msg": "User created successfully", "access_token": access_token}), 201


@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()
    # find by username
    user = User.query.filter_by(username=data['username']).first()

    if not user or not user.check_password(data['password']):
        return jsonify({"msg": "Invalid username or password"}), 401
    access_token = create_access_token(identity=str(user.id))

    return jsonify({"msg": "User login successfully", "access_token": access_token}), 200


@app.route('/api/profile', methods=['GET'])
@jwt_required()
def profile():
    current_user_id = get_jwt_identity()
    user = User.query.get(current_user_id)
    return jsonify({
        "username": user.username,
        "email": user.email
    }), 200

# user_preferences_manager2=UserPreferencesManager()
@app.route('/api/preferences', methods=['POST'])
@jwt_required()
def create_preferences():
    current_user_id = int(get_jwt_identity())
    data = request.get_json()
    # print(user_preferences_manager2.get_user_preferences_by_id(current_user_id))
    # Check if preferences already exist
    existing_preferences = UserPreferences.query.filter_by(user_id=current_user_id).first()
    if existing_preferences:
        return jsonify({"msg": "Preferences already exist. Use PUT to update."}), 400

    try:
        preferences = UserPreferences(
            user_id=current_user_id,
            current_city=data['user_profile']['current_location']['city'],
            current_district=data['user_profile']['current_location']['district'],
            target_city=data['user_profile']['target_location']['city'],
            target_district=data['user_profile']['target_location']['district'],
            age=data['user_profile']['personal_details']['age'],
            family_size=data['user_profile']['personal_details']['family_size'],
            monthly_net_income=data['user_profile']['personal_details']['monthly_net_income'],

            # Housing expenses
            monthly_rent=data['user_profile']['current_expenses']['housing']['monthly_rent'],
            electricity_bill=data['user_profile']['current_expenses']['housing']['electricity_bill'],
            natural_gas_bill=data['user_profile']['current_expenses']['housing']['natural_gas_bill'],
            water_bill=data['user_profile']['current_expenses']['housing']['water_bill'],
            internet_bill=data['user_profile']['current_expenses']['housing']['internet_bill'],

            # Transportation
            uses_public_transportation=data['user_profile']['current_expenses']['transportation'][
                'uses_public_transportation'],
            is_the_user_student=data['user_profile']['current_expenses']['transportation']['is_the_user_student'],
            public_transport_monthly_pass=data['user_profile']['current_expenses']['transportation'][
                'public_transport_monthly_pass'],

            # Education
            wants_education_analysis=data['user_profile']['current_expenses']['education']['wants_education_analysis'],
            target_university=data['user_profile']['current_expenses']['education'].get('target_university'),
            department_name=data['user_profile']['current_expenses']['education'].get('department_name'),
            current_tuition_semester=data['user_profile']['current_expenses']['education']['current_tuition_semester'],

            # Other expenses
            gym_membership=data['user_profile']['current_expenses']['other_expenses'].get('gym_membership'),
            entertainment_monthly=data['user_profile']['current_expenses']['other_expenses'].get(
                'entertainment_monthly'),
            clothing_monthly=data['user_profile']['current_expenses']['other_expenses'].get('clothing_monthly'),
            healthcare_monthly=data['user_profile']['current_expenses']['other_expenses'].get('healthcare_monthly'),
            subscriptions_monthly=data['user_profile']['current_expenses']['other_expenses'].get(
                'subscriptions_monthly'),
            travel_vacation_monthly=data['user_profile']['current_expenses']['other_expenses'].get(
                'travel_vacation_monthly'),

            # Housing preferences
            preferred_housing_type=data['user_profile']['housing_preferences']['preferred_housing_type'],
            number_of_rooms=data['user_profile']['housing_preferences']['number_of_rooms'],

            # Vehicle information
            owns_vehicle=data['user_profile']['vehicle_ownership']['owns_vehicle'],
            vehicle_type=data['user_profile']['vehicle_ownership'].get('vehicle_type'),
            fuel_tank_capacity=data['user_profile']['vehicle_ownership'].get('fuel_tank_capacity'),
            fuel_tank_monthly_fill_count=data['user_profile']['vehicle_ownership'].get('fuel_tank_monthly_fill_count'),
            distributor_preference=data['user_profile']['vehicle_ownership'].get('distributor_preference'),
            vehicle_fuel_type=data['user_profile']['vehicle_ownership'].get('vehicle_fuel_type'),

            # Shopping preferences
            grocery_preferences=data['user_profile']['shopping_preferences']['grocery_list']
        )

        db.session.add(preferences)
        db.session.commit()
        return jsonify({"msg": "Preferences created successfully"}), 201

    except KeyError as e:
        return jsonify({"msg": f"Missing required field: {str(e)}"}), 400
    except Exception as e:
        return jsonify({"msg": f"Error creating preferences: {str(e)}"}), 500


# user_preferences = UserPreferencesManager()
@app.route('/api/preferences', methods=['GET'])
@jwt_required()
def get_preferences():
    current_user_id = get_jwt_identity()
    preferences = UserPreferences.query.filter_by(user_id=current_user_id).first()
    print(current_user_id)
    # user_profile=user_preferences.get_user_preferences_by_id(current_user_id)
    # print(user_profile)
    # print("ahdadlksjljasdadslkjsajkdsa")
    # print(user_profile["user_profile"]["target_location"]["city"])
    if not preferences:
        return jsonify({"msg": "No preferences found"}), 404

    return jsonify({
        "user_profile": {
            "current_location": {
                "city": preferences.current_city,
                "district": preferences.current_district
            },
            "target_location": {
                "city": preferences.target_city,
                "district": preferences.target_district
            },
            "personal_details": {
                "age": preferences.age,
                "family_size": preferences.family_size,
                "monthly_net_income": preferences.monthly_net_income
            },
            "current_expenses": {
                "housing": {
                    "monthly_rent": preferences.monthly_rent,
                    "electricity_bill": preferences.electricity_bill,
                    "natural_gas_bill": preferences.natural_gas_bill,
                    "water_bill": preferences.water_bill,
                    "internet_bill": preferences.internet_bill,
                    "total_monthly_housing": sum([
                        preferences.monthly_rent,
                        preferences.electricity_bill,
                        preferences.natural_gas_bill,
                        preferences.water_bill,
                        preferences.internet_bill
                    ])
                },
                "transportation": {
                    "uses_public_transportation": preferences.uses_public_transportation,
                    "is_the_user_student": preferences.is_the_user_student,
                    "public_transport_monthly_pass": preferences.public_transport_monthly_pass
                },
                "education": {
                    "wants_education_analysis": preferences.wants_education_analysis,
                    "target_university": preferences.target_university,
                    "department_name": preferences.department_name,
                    "current_tuition_semester": preferences.current_tuition_semester,
                    "total_monthly_education": preferences.current_tuition_semester or 0
                },
                "other_expenses": {
                    "gym_membership": preferences.gym_membership,
                    "entertainment_monthly": preferences.entertainment_monthly,
                    "clothing_monthly": preferences.clothing_monthly,
                    "healthcare_monthly": preferences.healthcare_monthly,
                    "subscriptions_monthly": preferences.subscriptions_monthly,
                    "travel_vacation_monthly": preferences.travel_vacation_monthly,
                    "total_monthly_other": sum([
                        preferences.gym_membership or 0,
                        preferences.entertainment_monthly or 0,
                        preferences.clothing_monthly or 0,
                        preferences.healthcare_monthly or 0,
                        preferences.subscriptions_monthly or 0,
                        preferences.travel_vacation_monthly or 0
                    ])
                }
            },
            "housing_preferences": {
                "preferred_housing_type": preferences.preferred_housing_type,
                "number_of_rooms": preferences.number_of_rooms
            },
            "vehicle_ownership": {
                "owns_vehicle": preferences.owns_vehicle,
                "vehicle_type": preferences.vehicle_type,
                "fuel_tank_capacity": preferences.fuel_tank_capacity,
                "fuel_tank_monthly_fill_count": preferences.fuel_tank_monthly_fill_count,
                "distributor_preference": preferences.distributor_preference,
                "vehicle_fuel_type": preferences.vehicle_fuel_type
            },
            "shopping_preferences": {
                "grocery_list": preferences.grocery_preferences
            }
        }
    }), 200

user_preferences_manager=UserPreferencesManager()
root=RootLLM()
@app.route('/api/generate_root_llm_response', methods=['GET'])
@jwt_required()
def generate_root_llm_response():
    current_user_id = get_jwt_identity()
    preferences = UserPreferences.query.filter_by(user_id=current_user_id).first()
    print(current_user_id)
    
    if not preferences:
        return jsonify({"msg": "No preferences found"}), 404
    
    # Structure the user data the same way as get_preferences
    user_data = {
        "user_profile": {
            "current_location": {
                "city": preferences.current_city,
                "district": preferences.current_district
            },
            "target_location": {
                "city": preferences.target_city,
                "district": preferences.target_district
            },
            "personal_details": {
                "age": preferences.age,
                "family_size": preferences.family_size,
                "monthly_net_income": preferences.monthly_net_income
            },
            "current_expenses": {
                "housing": {
                    "monthly_rent": preferences.monthly_rent,
                    "electricity_bill": preferences.electricity_bill,
                    "natural_gas_bill": preferences.natural_gas_bill,
                    "water_bill": preferences.water_bill,
                    "internet_bill": preferences.internet_bill,
                    "total_monthly_housing": sum([
                        preferences.monthly_rent,
                        preferences.electricity_bill,
                        preferences.natural_gas_bill,
                        preferences.water_bill,
                        preferences.internet_bill
                    ])
                },
                "transportation": {
                    "uses_public_transportation": preferences.uses_public_transportation,
                    "is_the_user_student": preferences.is_the_user_student,
                    "public_transport_monthly_pass": preferences.public_transport_monthly_pass
                },
                "education": {
                    "wants_education_analysis": preferences.wants_education_analysis,
                    "target_university": preferences.target_university,
                    "department_name": preferences.department_name,
                    "current_tuition_semester": preferences.current_tuition_semester,
                    "total_monthly_education": preferences.current_tuition_semester or 0
                },
                "other_expenses": {
                    "gym_membership": preferences.gym_membership,
                    "entertainment_monthly": preferences.entertainment_monthly,
                    "clothing_monthly": preferences.clothing_monthly,
                    "healthcare_monthly": preferences.healthcare_monthly,
                    "subscriptions_monthly": preferences.subscriptions_monthly,
                    "travel_vacation_monthly": preferences.travel_vacation_monthly,
                    "total_monthly_other": sum([
                        preferences.gym_membership or 0,
                        preferences.entertainment_monthly or 0,
                        preferences.clothing_monthly or 0,
                        preferences.healthcare_monthly or 0,
                        preferences.subscriptions_monthly or 0,
                        preferences.travel_vacation_monthly or 0
                    ])
                }
            },
            "housing_preferences": {
                "preferred_housing_type": preferences.preferred_housing_type,
                "number_of_rooms": preferences.number_of_rooms
            },
            "vehicle_ownership": {
                "owns_vehicle": preferences.owns_vehicle,
                "vehicle_type": preferences.vehicle_type,
                "fuel_tank_capacity": preferences.fuel_tank_capacity,
                "fuel_tank_monthly_fill_count": preferences.fuel_tank_monthly_fill_count,
                "distributor_preference": preferences.distributor_preference,
                "vehicle_fuel_type": preferences.vehicle_fuel_type
            },
            "shopping_preferences": {
                "grocery_list": preferences.grocery_preferences
            }
        }
    }

    province = user_data["user_profile"]["target_location"]["city"]
    district = user_data["user_profile"]["target_location"]["district"]
    room_filter = user_data["user_profile"]["housing_preferences"]["number_of_rooms"]
    real_estate_results = root.get_real_estate_price_results(province, district, room_filter)

    # Initialize variables with default values
    education_results = None
    fuel_results = None
    transportation_results = None
    
    # Education Price Analysis (only if wanted)
    if user_data["user_profile"]["current_expenses"]["education"]["wants_education_analysis"]:
        university_name = user_data["user_profile"]["current_expenses"]["education"]["target_university"]
        department_name = user_data["user_profile"]["current_expenses"]["education"]["department_name"]
        education_results = root.get_education_price_reults(university_name, department_name)

    # Fuel Price Analysis (only if owns vehicle)
    if user_data["user_profile"]["vehicle_ownership"]["owns_vehicle"]:
        owns_vehicle = user_data["user_profile"]["vehicle_ownership"]["owns_vehicle"]
        current_province = user_data["user_profile"]["current_location"]["city"]
        target_province = user_data["user_profile"]["target_location"]["city"]
        fuel_tank_capacity = user_data["user_profile"]["vehicle_ownership"]["fuel_tank_capacity"]
        fuel_tank_monthly_fill_count = user_data["user_profile"]["vehicle_ownership"]["fuel_tank_monthly_fill_count"]
        distributor_preference = user_data["user_profile"]["vehicle_ownership"]["distributor_preference"]
        vehicle_fuel_type = user_data["user_profile"]["vehicle_ownership"]["vehicle_fuel_type"]
        fuel_results = root.get_fuel_price_results(owns_vehicle, current_province, target_province, fuel_tank_capacity,fuel_tank_monthly_fill_count, distributor_preference,vehicle_fuel_type)
        print(fuel_results)
    # Transportation Price Analysis (only if uses public transportation)
    if user_data["user_profile"]["current_expenses"]["transportation"]["uses_public_transportation"]:
        province = user_data["user_profile"]["target_location"]["city"]
        uses_public_transportation = user_data["user_profile"]["current_expenses"]["transportation"][
            "uses_public_transportation"]
        transportation_results = root.get_transportation_price_results(province, uses_public_transportation)

    # Market Price Analysis - Use grocery list directly as simple array
    grocery_items = user_data["user_profile"]["shopping_preferences"]["grocery_list"] or []

    market_results = root.get_market_price_results(grocery_items)
    #Utility price analysis
    utility_prices=root.get_utility_price_results(province)
    natural_gas_price = float(utility_prices['utilities']['natural_gas']['price_per_m3'])
    water_price = float(utility_prices['utilities']['water']['price_per_m3'])
    electricity_price = utility_prices['utilities']['electricity']['tariffs'][0]['price_per_kwh']
    average_electricity_price_for_four_people_household = calculate_average_price_for_electricity(electricity_price)
    average_natural_gas_price_for_four_people_household = calculate_average_price_for_natural_gas(natural_gas_price)
    average_water_price_for_four_people_household = calculate_average_price_for_water(water_price)

    return root.generate_root_llm_response(user_data, real_estate_results, education_results, fuel_results, transportation_results, market_results, utility_prices, average_electricity_price_for_four_people_household, average_natural_gas_price_for_four_people_household, average_water_price_for_four_people_household)

@app.route('/api/preferences', methods=['PUT'])
@jwt_required()
def update_preferences():
    current_user_id = get_jwt_identity()
    data = request.get_json()

    preferences = UserPreferences.query.filter_by(user_id=current_user_id).first()
    if not preferences:
        return jsonify({"msg": "No preferences found"}), 404

    try:
        # Update all fields
        preferences.current_city = data['user_profile']['current_location']['city']
        preferences.current_district = data['user_profile']['current_location']['district']
        preferences.target_city = data['user_profile']['target_location']['city']
        preferences.target_district = data['user_profile']['target_location']['district']
        preferences.age = data['user_profile']['personal_details']['age']
        preferences.family_size = data['user_profile']['personal_details']['family_size']
        preferences.monthly_net_income = data['user_profile']['personal_details']['monthly_net_income']

        # Housing expenses
        preferences.monthly_rent = data['user_profile']['current_expenses']['housing']['monthly_rent']
        preferences.electricity_bill = data['user_profile']['current_expenses']['housing']['electricity_bill']
        preferences.natural_gas_bill = data['user_profile']['current_expenses']['housing']['natural_gas_bill']
        preferences.water_bill = data['user_profile']['current_expenses']['housing']['water_bill']
        preferences.internet_bill = data['user_profile']['current_expenses']['housing']['internet_bill']

        # Transportation
        preferences.uses_public_transportation = data['user_profile']['current_expenses']['transportation'][
            'uses_public_transportation']
        preferences.is_the_user_student = data['user_profile']['current_expenses']['transportation'][
            'is_the_user_student']
        preferences.public_transport_monthly_pass = data['user_profile']['current_expenses']['transportation'][
            'public_transport_monthly_pass']

        # Education
        preferences.wants_education_analysis = data['user_profile']['current_expenses']['education'][
            'wants_education_analysis']
        preferences.target_university = data['user_profile']['current_expenses']['education'].get('target_university')
        preferences.department_name = data['user_profile']['current_expenses']['education'].get('department_name')
        preferences.current_tuition_semester = data['user_profile']['current_expenses']['education'][
            'current_tuition_semester']

        # Other expenses
        preferences.gym_membership = data['user_profile']['current_expenses']['other_expenses'].get('gym_membership')
        preferences.entertainment_monthly = data['user_profile']['current_expenses']['other_expenses'].get(
            'entertainment_monthly')
        preferences.clothing_monthly = data['user_profile']['current_expenses']['other_expenses'].get(
            'clothing_monthly')
        preferences.healthcare_monthly = data['user_profile']['current_expenses']['other_expenses'].get(
            'healthcare_monthly')
        preferences.subscriptions_monthly = data['user_profile']['current_expenses']['other_expenses'].get(
            'subscriptions_monthly')
        preferences.travel_vacation_monthly = data['user_profile']['current_expenses']['other_expenses'].get(
            'travel_vacation_monthly')

        # Housing preferences
        preferences.preferred_housing_type = data['user_profile']['housing_preferences']['preferred_housing_type']
        preferences.number_of_rooms = data['user_profile']['housing_preferences']['number_of_rooms']

        # Vehicle information
        preferences.owns_vehicle = data['user_profile']['vehicle_ownership']['owns_vehicle']
        preferences.vehicle_type = data['user_profile']['vehicle_ownership'].get('vehicle_type')
        preferences.fuel_tank_capacity = data['user_profile']['vehicle_ownership'].get('fuel_tank_capacity')
        preferences.fuel_tank_monthly_fill_count = data['user_profile']['vehicle_ownership'].get(
            'fuel_tank_monthly_fill_count')
        preferences.distributor_preference = data['user_profile']['vehicle_ownership'].get('distributor_preference')
        preferences.vehicle_fuel_type = data['user_profile']['vehicle_ownership'].get('vehicle_fuel_type')

        # Shopping preferences
        preferences.grocery_preferences = data['user_profile']['shopping_preferences']['grocery_list']

        db.session.commit()
        return jsonify({"msg": "Preferences updated successfully"}), 200

    except KeyError as e:
        return jsonify({"msg": f"Missing required field: {str(e)}"}), 400
    except Exception as e:
        return jsonify({"msg": f"Error updating preferences: {str(e)}"}), 500


@app.route('/api/preferences', methods=['DELETE'])
@jwt_required()
def delete_preferences():
    current_user_id = get_jwt_identity()
    preferences = UserPreferences.query.filter_by(user_id=current_user_id).first()

    if not preferences:
        return jsonify({"msg": "No preferences found"}), 404

    try:
        db.session.delete(preferences)
        db.session.commit()
        return jsonify({"msg": "Preferences deleted successfully"}), 200
    except Exception as e:
        return jsonify({"msg": f"Error deleting preferences: {str(e)}"}), 500


# Database configuration for utilities_turkey database
UTILITIES_DB_HOST = 'localhost'
UTILITIES_DB_PORT = 3306
UTILITIES_DB_USER = 'root'
UTILITIES_DB_PASSWORD = 'rootpassword'
UTILITIES_DB_NAME = 'utilities_turkey'

# Create a separate engine for utilities database
utilities_engine = create_engine(
    f'mysql+mysqlconnector://{UTILITIES_DB_USER}:{UTILITIES_DB_PASSWORD}@{UTILITIES_DB_HOST}:{UTILITIES_DB_PORT}/{UTILITIES_DB_NAME}'
)


@app.route('/api/provinces', methods=['GET'])
@cross_origin()
def get_provinces():
    """
    Get all provinces from the utilities_turkey database
    Returns: JSON array of provinces with id, province_name, and province_code
    """
    try:
        with utilities_engine.connect() as connection:
            query = text("""
                SELECT id, province_name, province_code 
                FROM provinces 
                ORDER BY province_name
            """)
            result = connection.execute(query)

            provinces = []
            for row in result:
                provinces.append({
                    'id': row.id,
                    'province_name': row.province_name,
                    'province_code': row.province_code
                })

            return jsonify({
                'success': True,
                'data': provinces,
                'count': len(provinces)
            }), 200

    except SQLAlchemyError as e:
        return jsonify({
            'success': False,
            'error': 'Database error occurred',
            'message': str(e)
        }), 500
    except Exception as e:
        return jsonify({
            'success': False,
            'error': 'An unexpected error occurred',
            'message': str(e)
        }), 500


@app.route('/api/provinces/<int:province_id>/districts', methods=['GET'])
@cross_origin()
def get_districts_by_province_id(province_id):
    """
    Get all districts for a specific province by province ID
    Args: province_id (int): The ID of the province
    Returns: JSON array of districts with id, district_name, and province info
    """
    try:
        with utilities_engine.connect() as connection:
            # First check if province exists
            province_query = text("""
                SELECT id, province_name, province_code 
                FROM provinces 
                WHERE id = :province_id
            """)
            province_result = connection.execute(province_query, {'province_id': province_id})
            province = province_result.fetchone()

            if not province:
                return jsonify({
                    'success': False,
                    'error': 'Province not found',
                    'message': f'Province with ID {province_id} does not exist'
                }), 404

            # Get districts for the province
            districts_query = text("""
                SELECT d.id, d.district_name, d.province_id
                FROM districts d
                WHERE d.province_id = :province_id
                ORDER BY d.district_name
            """)
            districts_result = connection.execute(districts_query, {'province_id': province_id})

            districts = []
            for row in districts_result:
                districts.append({
                    'id': row.id,
                    'district_name': row.district_name,
                    'province_id': row.province_id
                })

            return jsonify({
                'success': True,
                'province': {
                    'id': province.id,
                    'province_name': province.province_name,
                    'province_code': province.province_code
                },
                'districts': districts,
                'count': len(districts)
            }), 200

    except SQLAlchemyError as e:
        return jsonify({
            'success': False,
            'error': 'Database error occurred',
            'message': str(e)
        }), 500
    except Exception as e:
        return jsonify({
            'success': False,
            'error': 'An unexpected error occurred',
            'message': str(e)
        }), 500


@app.route('/api/provinces/<province_name>/districts', methods=['GET'])
@cross_origin()
def get_districts_by_province_name(province_name):
    """
    Get all districts for a specific province by province name
    Args: province_name (str): The name of the province
    Returns: JSON array of districts with id, district_name, and province info
    """
    try:
        with utilities_engine.connect() as connection:
            # First check if province exists and get its info
            province_query = text("""
                SELECT id, province_name, province_code 
                FROM provinces 
                WHERE province_name = :province_name
            """)
            province_result = connection.execute(province_query, {'province_name': province_name})
            province = province_result.fetchone()

            if not province:
                return jsonify({
                    'success': False,
                    'error': 'Province not found',
                    'message': f'Province "{province_name}" does not exist'
                }), 404

            # Get districts for the province
            districts_query = text("""
                SELECT d.id, d.district_name, d.province_id
                FROM districts d
                INNER JOIN provinces p ON d.province_id = p.id
                WHERE p.province_name = :province_name
                ORDER BY d.district_name
            """)
            districts_result = connection.execute(districts_query, {'province_name': province_name})

            districts = []
            for row in districts_result:
                districts.append({
                    'id': row.id,
                    'district_name': row.district_name,
                    'province_id': row.province_id
                })

            return jsonify({
                'success': True,
                'province': {
                    'id': province.id,
                    'province_name': province.province_name,
                    'province_code': province.province_code
                },
                'districts': districts,
                'count': len(districts)
            }), 200

    except SQLAlchemyError as e:
        return jsonify({
            'success': False,
            'error': 'Database error occurred',
            'message': str(e)
        }), 500
    except Exception as e:
        return jsonify({
            'success': False,
            'error': 'An unexpected error occurred',
            'message': str(e)
        }), 500


@app.route('/api/districts', methods=['GET'])
def get_all_districts():
    """
    Get all districts with their province information
    Optional query parameters:
    - search: Filter districts by name (partial match)
    Returns: JSON array of all districts with province information
    """
    try:
        search_term = request.args.get('search', '').strip()

        with utilities_engine.connect() as connection:
            if search_term:
                query = text("""
                    SELECT d.id, d.district_name, d.province_id, 
                           p.province_name, p.province_code
                    FROM districts d
                    INNER JOIN provinces p ON d.province_id = p.id
                    WHERE d.district_name LIKE :search_term
                    ORDER BY p.province_name, d.district_name
                """)
                result = connection.execute(query, {'search_term': f'%{search_term}%'})
            else:
                query = text("""
                    SELECT d.id, d.district_name, d.province_id, 
                           p.province_name, p.province_code
                    FROM districts d
                    INNER JOIN provinces p ON d.province_id = p.id
                    ORDER BY p.province_name, d.district_name
                """)
                result = connection.execute(query)

            districts = []
            for row in result:
                districts.append({
                    'id': row.id,
                    'district_name': row.district_name,
                    'province_id': row.province_id,
                    'province_name': row.province_name,
                    'province_code': row.province_code
                })

            return jsonify({
                'success': True,
                'data': districts,
                'count': len(districts),
                'search_term': search_term if search_term else None
            }), 200

    except SQLAlchemyError as e:
        return jsonify({
            'success': False,
            'error': 'Database error occurred',
            'message': str(e)
        }), 500
    except Exception as e:
        return jsonify({
            'success': False,
            'error': 'An unexpected error occurred',
            'message': str(e)
        }), 500

# Run the app
if __name__ == '__main__':
    app.run(debug=True)