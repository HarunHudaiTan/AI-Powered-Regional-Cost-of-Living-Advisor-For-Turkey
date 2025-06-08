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


class UtilitiesPrices:
    """Class to handle all utility prices for a given city"""

    def __init__(self, db_connection: DatabaseConnection = None):
        self.db = db_connection or DatabaseConnection()

    def get_all_utility_prices(self, city_name: str) -> Dict[str, Any]:
        """
        Get all utility prices for a given city (city-specific + national services)

        Args:
            city_name (str): Name of the city

        Returns:
            Dict containing all utility prices including city-specific and national services
        """
        try:
            conn = self.db.get_connection()
            cursor = conn.cursor(dictionary=True)

            # Get city-specific utilities
            natural_gas = self.get_natural_gas_price(cursor, city_name)
            water = self._get_water_price(cursor, city_name)

            # Get national services (same for all cities)
            electricity = self._get_electricity_tariffs(cursor)
            internet = self._get_internet_packages(cursor)

            # Check if city exists in either table
            city_exists = natural_gas.get('city_found', False) or water.get('city_found', False)

            if not city_exists:
                cursor.close()
                conn.close()
                return {
                    'city_name': city_name,
                    'available': False,
                    'message': 'City not found in utility database',
                    'utilities': {}
                }

            utilities = {}

            # Add city-specific utilities
            if natural_gas['available']:
                utilities['natural_gas'] = {
                    'service_name': 'Natural Gas',
                    'service_type': 'city_specific',
                    'price_per_m3': natural_gas['price_per_m3'],
                    'currency': natural_gas['currency'],
                    'unit': 'm³',
                    'notes': natural_gas['notes']
                }

            if water['available']:
                utilities['water'] = {
                    'service_name': 'Water',
                    'service_type': 'city_specific',
                    'price_per_m3': water['price_per_m3'],
                    'currency': water['currency'],
                    'unit': 'm³',
                    'notes': water['notes']
                }

            # Add national services (always included)
            utilities['electricity'] = {
                'service_name': 'Electricity',
                'service_type': 'national',
                'tariffs': electricity
            }

            utilities['internet'] = {
                'service_name': 'Internet',
                'service_type': 'national',
                'packages': internet
            }

            result = {
                'city_name': city_name,
                'available': True,
                'utilities': utilities,
                'city_specific_utilities': [k for k, v in utilities.items() if
                                            v.get('service_type') == 'city_specific'],
                'national_utilities': [k for k, v in utilities.items() if v.get('service_type') == 'national'],
                'total_utilities': len(utilities)
            }

            cursor.close()
            conn.close()

            return result

        except mysql.connector.Error as e:
            logging.error(f"Database error in get_all_utility_prices: {e}")
            return {'error': str(e)}
        except Exception as e:
            logging.error(f"Unexpected error in get_all_utility_prices: {e}")
            return {'error': str(e)}

    def get_natural_gas_price(self, cursor, city_name: str) -> Dict[str, Any]:
        """Get natural gas price for the city"""
        query = """
        SELECT city_name, price_per_m3, currency, notes
        FROM natural_gas_tariffs 
        WHERE city_name = %s
        """
        cursor.execute(query, (city_name,))
        result = cursor.fetchone()

        if result:
            return {
                'city_found': True,
                'available': result['price_per_m3'] is not None,
                'price_per_m3': result['price_per_m3'],
                'currency': result['currency'],
                'notes': result['notes']
            }
        else:
            return {
                'city_found': False,
                'available': False,
                'price_per_m3': None,
                'currency': 'TRY',
                'notes': 'City not found'
            }

    def _get_water_price(self, cursor, city_name: str) -> Dict[str, Any]:
        """Get water price for the city"""
        query = """
        SELECT city_name, price_per_m3, currency, notes
        FROM water_tariffs 
        WHERE city_name = %s
        """
        cursor.execute(query, (city_name,))
        result = cursor.fetchone()

        if result:
            return {
                'city_found': True,
                'available': result['price_per_m3'] is not None,
                'price_per_m3': result['price_per_m3'],
                'currency': result['currency'],
                'notes': result['notes']
            }
        else:
            return {
                'city_found': False,
                'available': False,
                'price_per_m3': None,
                'currency': 'TRY',
                'notes': 'City not found'
            }

    def _get_electricity_tariffs(self, cursor) -> List[Dict[str, Any]]:
        """Get electricity tariffs (same for all cities)"""
        query = """
        SELECT tariff_type, time_period, consumption_threshold, 
               price_per_kwh, currency
        FROM electricity_tariffs
        """
        cursor.execute(query)
        results = cursor.fetchall()

        tariffs = []
        for row in results:
            tariffs.append({
                'tariff_type': row['tariff_type'],
                'time_period': row['time_period'],
                'consumption_threshold': row['consumption_threshold'],
                'price_per_kwh': float(row['price_per_kwh']),
                'currency': row['currency']
            })

        return tariffs

    def _get_internet_packages(self, cursor) -> List[Dict[str, Any]]:
        """Get all internet packages (same for all cities)"""
        query = """
        SELECT p.provider_name, pkg.package_name, pkg.speed_mbps, 
               pkg.monthly_price, pkg.promotional_price, pkg.promotional_months,
               pkg.contract_required, pkg.contract_months, pkg.features, pkg.currency
        FROM internet_packages pkg
        JOIN internet_providers p ON pkg.provider_id = p.id
        ORDER BY p.provider_name, pkg.speed_mbps ASC
        """
        cursor.execute(query)
        results = cursor.fetchall()

        packages = []
        for row in results:
            packages.append({
                'provider_name': row['provider_name'],
                'package_name': row['package_name'],
                'speed_mbps': row['speed_mbps'],
                'monthly_price': float(row['monthly_price']),
                'promotional_price': float(row['promotional_price']) if row['promotional_price'] else None,
                'promotional_months': row['promotional_months'],
                'contract_required': bool(row['contract_required']),
                'contract_months': row['contract_months'],
                'features': row['features'],
                'currency': row['currency']
            })

        return packages


# # Example usage and testing
# if __name__ == "__main__":
#     # Configure logging
#     logging.basicConfig(level=logging.INFO)
#
#     # Initialize utilities class
#     utilities = UtilitiesPrices()
#
#     # Test with Ankara
#     city_name = "Ankara"
#
#     print(f"=== UTILITY PRICES FOR {city_name.upper()} ===")
#     utility_data = utilities.get_all_utility_prices(city_name)
#     print(json.dumps(utility_data, indent=2, ensure_ascii=False, cls=DecimalEncoder))