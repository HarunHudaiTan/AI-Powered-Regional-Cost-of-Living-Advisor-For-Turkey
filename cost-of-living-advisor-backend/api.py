from flask import Flask, request, jsonify
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import timedelta
import os
import mysql.connector
from mysql.connector import Error

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

# Enhanced CORS configuration to handle preflight requests properly
CORS(app,
     origins=["http://localhost:4200", "http://127.0.0.1:4200"],
     methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
     allow_headers=["Content-Type", "Authorization", "Access-Control-Allow-Credentials"],
     supports_credentials=True)


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
    parking_fees = db.Column(db.Float, nullable=True)

    # Education
    wants_education_analysis = db.Column(db.Boolean, default=False)
    target_university = db.Column(db.String(200), nullable=True)
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
    fuel_tank_capacity = db.Column(db.String(20), nullable=True)
    fuel_tank_monthly_fill_count = db.Column(db.Integer, nullable=True)

    # Shopping Preferences
    grocery_preferences = db.Column(db.JSON, nullable=True)  # Store the structured grocery preferences as JSON


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
        response = jsonify({'message': 'OK'})
        response.headers.add("Access-Control-Allow-Origin", "*")
        response.headers.add('Access-Control-Allow-Headers', "Content-Type,Authorization")
        response.headers.add('Access-Control-Allow-Methods', "GET,PUT,POST,DELETE,OPTIONS")
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


@app.route('/api/preferences', methods=['POST'])
@jwt_required()
def create_preferences():
    current_user_id = int(get_jwt_identity())
    data = request.get_json()

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
            parking_fees=data['user_profile']['current_expenses']['transportation'].get('parking_fees'),

            # Education
            wants_education_analysis=data['user_profile']['current_expenses']['education']['wants_education_analysis'],
            target_university=data['user_profile']['current_expenses']['education'].get('target_university'),
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
            vehicle_type=data['user_profile']['vehicle_ownership']['vehicle_type'],
            fuel_tank_capacity=data['user_profile']['vehicle_ownership']['fuel_tank_capacity'],
            fuel_tank_monthly_fill_count=data['user_profile']['vehicle_ownership']['fuel_tank_monthly_fill_count'],

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


@app.route('/api/preferences', methods=['GET'])
@jwt_required()
def get_preferences():
    current_user_id = get_jwt_identity()
    preferences = UserPreferences.query.filter_by(user_id=current_user_id).first()

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
                    "public_transport_monthly_pass": preferences.public_transport_monthly_pass,
                    "parking_fees": preferences.parking_fees,
                    "total_monthly_transport": sum([
                        preferences.public_transport_monthly_pass or 0,
                        preferences.parking_fees or 0
                    ])
                },
                "education": {
                    "wants_education_analysis": preferences.wants_education_analysis,
                    "target_university": preferences.target_university,
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
                "fuel_tank_monthly_fill_count": preferences.fuel_tank_monthly_fill_count
            },
            "shopping_preferences": {
                "grocery_list": preferences.grocery_preferences
            }
        }
    }), 200


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
        preferences.parking_fees = data['user_profile']['current_expenses']['transportation'].get('parking_fees')

        # Education
        preferences.wants_education_analysis = data['user_profile']['current_expenses']['education'][
            'wants_education_analysis']
        preferences.target_university = data['user_profile']['current_expenses']['education'].get('target_university')
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
        preferences.vehicle_type = data['user_profile']['vehicle_ownership']['vehicle_type']
        preferences.fuel_tank_capacity = data['user_profile']['vehicle_ownership']['fuel_tank_capacity']
        preferences.fuel_tank_monthly_fill_count = data['user_profile']['vehicle_ownership'][
            'fuel_tank_monthly_fill_count']

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


# Run the app
if __name__ == '__main__':
    app.run(debug=True)