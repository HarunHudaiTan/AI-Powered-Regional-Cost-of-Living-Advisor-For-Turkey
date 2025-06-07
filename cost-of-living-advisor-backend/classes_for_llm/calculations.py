import json

from classes_for_llm.fuel_and_transportation_prices.Fuel_Prices import FuelPrices
from classes_for_llm.fuel_and_transportation_prices.transportation_prices import TransportationPrices, DecimalEncoder
from classes_for_llm.real_estate_and_utility_prices.utility_prices import UtilitiesPrices

utilities = UtilitiesPrices()
transportation = TransportationPrices()
fuel_prices=FuelPrices()
city_name = "Ankara"

def calculate_average_price_for_water(meter_square_price):
    return meter_square_price*20

def calculate_average_price_for_natural_gas(meter_square_price):
    return meter_square_price*125

def calculate_average_price_for_electricity(price_per_kwh):
    return price_per_kwh*416
def calculate_fuel_price_for_current_and_target_city(current_city, target_city):
    current_fuel_price=fuel_prices.fetch_fuel_prices(current_city)
    target_city_fuel_price=fuel_prices.fetch_fuel_prices(target_city)
    return current_fuel_price,target_city_fuel_price


# utility_prices=utilities.get_all_utility_prices(city_name)
# transportation_prices=transportation.get_all_transportation_prices(city_name)
# print(json.dumps(transportation_prices,indent=2, ensure_ascii=False,cls=DecimalEncoder))
# print(json.dumps(utility_prices, indent=2, ensure_ascii=False, cls=DecimalEncoder))
# transportation_prices=transportation.get_all_transportation_prices(city_name)
# print(calculate_average_price_for_water(utility_prices['utilities']['water']['price_per_m3']))
# print(calculate_average_price_for_natural_gas(utility_prices['utilities']['natural_gas']['price_per_m3']))
# print(calculate_average_price_for_electricity(utility_prices['utilities']['electricity']['tariffs'][0]['price_per_kwh']))