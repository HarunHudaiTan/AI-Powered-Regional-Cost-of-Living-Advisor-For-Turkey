import jwt
import mysql.connector
from mysql.connector import Error

class UserPreferencesManager:
    def __init__(self):
        # Database configuration (should match the main API)
        self.DB_HOST = 'localhost'
        self.DB_PORT = 3306
        self.DB_USER = 'root'
        self.DB_PASSWORD = 'rootpassword'
        self.DB_NAME = 'user_details_and_preferences'
        # JWT secret key (should match the main API)
        self.SECRET_KEY = 'Bj7qxGUEPQvTUpee9DqFltEqlPvEIod1yK6Pr89qFxJJtFfZKNXnhuARVgYIfoCM8ax0Db4D2LIZtxxbkrM1HZkmGZh5OUC3j6HtxgVIZiud3fifcOSa/xJZ5VNePG2VA/mWELM5XTtLi5C8Yfv3ex2QN5Hu0E8k7lY9sTHo1N4='
        # Current user token storage
        self.current_user_token = None

    def get_database_connection(self):
        """Get database connection"""
        try:
            return mysql.connector.connect(
                host=self.DB_HOST,
                port=self.DB_PORT,
                user=self.DB_USER,
                password=self.DB_PASSWORD,
                database=self.DB_NAME,
                charset='utf8mb4',
                collation='utf8mb4_unicode_ci'
            )
        except Error as e:
            print(f"Database connection error: {e}")
            raise e

    def decode_jwt_token(self, token):
        """Decode JWT token to get user ID"""
        try:
            # Decode the JWT token
            decoded_token = jwt.decode(token, self.SECRET_KEY, algorithms=['HS256'])
            user_id = decoded_token.get('sub')  # 'sub' is the user ID claim
            return int(user_id)
        except jwt.ExpiredSignatureError:
            raise Exception("Token has expired")
        except jwt.InvalidTokenError:
            raise Exception("Invalid token")

    def set_current_user_token(self, jwt_token):
        """
        Set the current user's JWT token for subsequent operations
        
        Args:
            jwt_token (str): JWT token containing user identity
        """
        self.current_user_token = jwt_token

    def get_current_user_id(self):
        """
        Get the current user ID from the stored token
        
        Returns:
            int: User ID from the stored token
        """
        if not self.current_user_token:
            raise Exception("No current user token set")
        return self.decode_jwt_token(self.current_user_token)

    def get_user_preferences(self, jwt_token=None):
        """
        Get user preferences from database using JWT token
        
        Args:
            jwt_token (str, optional): JWT token containing user identity. 
                                     If not provided, uses the stored current user token.
            
        Returns:
            dict: User preferences data structured similar to the API response
        """
        try:
            # Use provided token or the stored current user token
            token_to_use = jwt_token or self.current_user_token
            if not token_to_use:
                raise Exception("No JWT token provided and no current user token set")
            
            # Decode JWT token to get user ID
            user_id = self.decode_jwt_token(token_to_use)
            
            # Use the by_id method to get preferences
            return self.get_user_preferences_by_id(user_id)
            
        except Exception as e:
            return {"error": f"Error retrieving user preferences: {str(e)}"}

    def get_user_preferences_by_id(self, user_id):
        """
        Get user preferences from database using user ID directly
        
        Args:
            user_id (int): User ID to get preferences for
            
        Returns:
            dict: User preferences data structured similar to the API response
        """
        try:
            # Connect to database
            connection = self.get_database_connection()
            cursor = connection.cursor(dictionary=True)
            
            # Query user preferences
            query = """
            SELECT * FROM user_preferences 
            WHERE user_id = %s
            """
            cursor.execute(query, (user_id,))
            preferences = cursor.fetchone()
            
            cursor.close()
            connection.close()
            
            if not preferences:
                return {"error": "No preferences found for this user"}
            
            # Structure the response similar to the API
            return {
                "user_profile": {
                    "current_location": {
                        "city": preferences['current_city'],
                        "district": preferences['current_district']
                    },
                    "target_location": {
                        "city": preferences['target_city'],
                        "district": preferences['target_district']
                    },
                    "personal_details": {
                        "age": preferences['age'],
                        "family_size": preferences['family_size'],
                        "monthly_net_income": preferences['monthly_net_income']
                    },
                    "current_expenses": {
                        "housing": {
                            "monthly_rent": preferences['monthly_rent'],
                            "electricity_bill": preferences['electricity_bill'],
                            "natural_gas_bill": preferences['natural_gas_bill'],
                            "water_bill": preferences['water_bill'],
                            "internet_bill": preferences['internet_bill'],
                            "total_monthly_housing": (
                                preferences['monthly_rent'] +
                                preferences['electricity_bill'] +
                                preferences['natural_gas_bill'] +
                                preferences['water_bill'] +
                                preferences['internet_bill']
                            )
                        },
                        "transportation": {
                            "uses_public_transportation": bool(preferences['uses_public_transportation']),
                            "is_the_user_student": bool(preferences['is_the_user_student']),
                            "public_transport_monthly_pass": preferences['public_transport_monthly_pass']
                        },
                        "education": {
                            "wants_education_analysis": bool(preferences['wants_education_analysis']),
                            "target_university": preferences['target_university'],
                            "department_name": preferences['department_name'],
                            "current_tuition_semester": preferences['current_tuition_semester'],
                            "total_monthly_education": preferences['current_tuition_semester'] or 0
                        },
                        "other_expenses": {
                            "gym_membership": preferences['gym_membership'],
                            "entertainment_monthly": preferences['entertainment_monthly'],
                            "clothing_monthly": preferences['clothing_monthly'],
                            "healthcare_monthly": preferences['healthcare_monthly'],
                            "subscriptions_monthly": preferences['subscriptions_monthly'],
                            "travel_vacation_monthly": preferences['travel_vacation_monthly'],
                            "total_monthly_other": sum([
                                preferences['gym_membership'] or 0,
                                preferences['entertainment_monthly'] or 0,
                                preferences['clothing_monthly'] or 0,
                                preferences['healthcare_monthly'] or 0,
                                preferences['subscriptions_monthly'] or 0,
                                preferences['travel_vacation_monthly'] or 0
                            ])
                        }
                    },
                    "housing_preferences": {
                        "preferred_housing_type": preferences['preferred_housing_type'],
                        "number_of_rooms": preferences['number_of_rooms']
                    },
                    "vehicle_ownership": {
                        "owns_vehicle": bool(preferences['owns_vehicle']),
                        "vehicle_type": preferences['vehicle_type'],
                        "fuel_tank_capacity": preferences['fuel_tank_capacity'],
                        "fuel_tank_monthly_fill_count": preferences['fuel_tank_monthly_fill_count'],
                        "distributor_preference": preferences['distributor_preference'],
                        "vehicle_fuel_type": preferences['vehicle_fuel_type']
                    },
                    "shopping_preferences": {
                        "grocery_list": preferences['grocery_preferences']
                    }
                }
            }
            
        except Exception as e:
            return {"error": f"Error retrieving user preferences: {str(e)}"} 