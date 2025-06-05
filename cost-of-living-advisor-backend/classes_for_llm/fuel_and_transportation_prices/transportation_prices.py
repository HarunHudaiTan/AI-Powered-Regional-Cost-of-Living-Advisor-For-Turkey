import mysql.connector
from typing import Dict, List, Optional, Any
import logging
import json
from decimal import Decimal


class DecimalEncoder(json.JSONEncoder):
    """Custom JSON encoder to handle Decimal objects"""
    def default(self, obj):
        if isinstance(obj, Decimal):
            return float(obj)
        return super(DecimalEncoder, self).default(obj)


class DatabaseConnection:
    """Database connection handler"""

    def __init__(self, host='localhost', port=3306, database='utilities_turkey',
                 username='utilities_user', password='utilities_pass'):
        self.config = {
            'host': host,
            'port': port,
            'database': database,
            'user': username,
            'password': password,
            'charset': 'utf8mb4',
            'collation': 'utf8mb4_unicode_ci'
        }

    def get_connection(self):
        """Get database connection"""
        try:
            return mysql.connector.connect(**self.config)
        except mysql.connector.Error as e:
            logging.error(f"Database connection error: {e}")
            raise


class TransportationPrices:
    """Class to handle all transportation prices for a given city"""

    def __init__(self, db_connection: DatabaseConnection = None):
        self.db = db_connection or DatabaseConnection()

    def get_all_transportation_prices(self, city_name: str) -> Dict[str, Any]:
        """
        Get all transportation prices for a given city

        Args:
            city_name (str): Name of the city

        Returns:
            Dict containing all transportation prices for the city
        """
        try:
            conn = self.db.get_connection()
            cursor = conn.cursor(dictionary=True)

            query = """
            SELECT city_name, transport_type, category, price
            FROM city_transportation
            WHERE city_name = %s
            ORDER BY transport_type, category
            """

            cursor.execute(query, (city_name,))
            results = cursor.fetchall()

            cursor.close()
            conn.close()

            if not results:
                return {
                    'city_name': city_name,
                    'available': False,
                    'transportation_options_and_prices': [],
                    'message': 'No transportation data found for this city'
                }

            # Group results by transportation type
            transport_groups = {}

            for row in results:
                transport_type = row['transport_type']
                if transport_type not in transport_groups:
                    transport_groups[transport_type] = {
                        'transport_type': transport_type,
                        'prices': []
                    }

                transport_groups[transport_type]['prices'].append({
                    'category': row['category'],
                    'price': float(row['price']),
                    'currency': 'TRY'
                })

            return {
                'city_name': city_name,
                'available': True,
                'transportation_options_and_prices': list(transport_groups.values()),
                'total_options': len(transport_groups)
            }

        except mysql.connector.Error as e:
            logging.error(f"Database error in get_all_transportation_prices: {e}")
            return {'error': str(e)}
        except Exception as e:
            logging.error(f"Unexpected error in get_all_transportation_prices: {e}")
            return {'error': str(e)}


# Example usage and testing
if __name__ == "__main__":
    # Configure logging
    logging.basicConfig(level=logging.INFO)

    # Initialize class
    transportation = TransportationPrices()

    # Test with Ankara
    city_name = "Yozgat"

    print(f"=== TRANSPORTATION PRICES FOR {city_name.upper()} ===")
    transport_data = transportation.get_all_transportation_prices(city_name)
    print(json.dumps(transport_data, indent=2, ensure_ascii=False, cls=DecimalEncoder)) 