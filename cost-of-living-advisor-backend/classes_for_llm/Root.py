from classes_for_llm.fuel_and_transportation_prices.Fuel_Prices import FuelPrices
from classes_for_llm.fuel_and_transportation_prices.transportation_prices import TransportationPrices
from classes_for_llm.market_prices.market_price_fetcher import Market_Price_Fetcher
from classes_for_llm.real_estate_and_utility_prices.Search import Search
from classes_for_llm.real_estate_and_utility_prices.real_estate_parse import RealEstate
from classes_for_llm.university_prices.EducationAgent import EducationAgent
from proj_llm_agent import LLM_Agent


class RootLLM(LLM_Agent):
    def __init__(self):
        super().__init__(name="ROOT LLM", role=self.system_instructions, response_mime_type="application/json")
        self.user_info = None
    system_instructions="""

"""


    def get_real_estate_price_results(self,province,district,room_filter=None):
        real_estate_prices=RealEstate()
        google_search=Search()
        search_results=google_search.search("site:emlakjet.com "+province+" "+district+" kiralık daire fiyatları")
        print(search_results)
        parsed_links=google_search.parse_search_links(search_results)
        real_estate_price_results=real_estate_prices.parse_real_estate_results(parsed_links[0], 4,room_filter)
        return real_estate_price_results

    def get_education_price_reults(self,university_name,department_name):
        education_agent=EducationAgent()
        education_price_information=education_agent.generate_education_agent_response(university_name,department_name)
        return education_price_information

    def get_fuel_price_results(self,current_province,target_province,fuel_tank_capacity,fuel_tank_monthly_fill_count):
        fuel_prices=FuelPrices()
        current_province_fuel_prices=fuel_prices.fetch_fuel_prices(current_province)
        target_province_fuel_prices=fuel_prices.fetch_fuel_prices(target_province)

        current_monthly_fuel_prices=current_province_fuel_prices*fuel_tank_monthly_fill_count*fuel_tank_capacity
        target_city_monthly_fuel_prices=target_province_fuel_prices*fuel_tank_monthly_fill_count*fuel_tank_capacity

        return current_monthly_fuel_prices,target_city_monthly_fuel_prices

    def get_transportation_price_results(self, province, uses_public_transportation):
        if uses_public_transportation:
            transportation_prices = TransportationPrices()
            transportation_prices_for_province = transportation_prices.get_all_transportation_prices(province)
            print(transportation_prices_for_province)
            return transportation_prices_for_province

    def get_market_price_results(self,market_list):
        market_prices=Market_Price_Fetcher()


root=RootLLM()
print(root.get_transportation_price_results("Adana",True))

