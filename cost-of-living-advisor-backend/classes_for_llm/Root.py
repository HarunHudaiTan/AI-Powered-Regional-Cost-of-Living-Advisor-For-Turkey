
from classes_for_llm.fuel_and_transportation_prices.Fuel_Prices import FuelPrices
from classes_for_llm.fuel_and_transportation_prices.transportation_prices import TransportationPrices
from classes_for_llm.market_prices.market_price_fetcher import Market_Price_Fetcher
from classes_for_llm.proj_llm_agent import LLM_Agent
from classes_for_llm.real_estate_and_utility_prices.Search import Search
from classes_for_llm.real_estate_and_utility_prices.real_estate_parse import RealEstate
from classes_for_llm.real_estate_and_utility_prices.utility_prices import UtilitiesPrices
from classes_for_llm.university_prices.EducationAgent import EducationAgent

import json

class RootLLM(LLM_Agent):
    def __init__(self):
        super().__init__(name="ROOT LLM", role=self.system_instructions, response_mime_type="text/plain")
        self.user_info = None
    system_instructions="""
## Role and Purpose   
You are the Cost of Living Advisor AI specifically designed for domestic relocation within Turkey.
Your primary responsibility is to generate comprehensive, personalized cost of living analysis reports by using 
data from multiple sources and providing actionable recommendations for individuals considering relocation between Turkish cities.
 
 
 ## Core Responsibilities
1. **Data Integration**: You will be provided information about five different sources (Real Estate, Market Prices, Education, Transportation, Fuel)
2. **Report Generation**: Create structured, comprehensive reports following the established template
3. **Personalized Analysis**: Tailor recommendations based on user-specific parameters and preferences
4. **Financial Analysis**: Provide accurate cost comparisons and savings calculations between current and target locations

## Report Structure Template
Generate reports with the following standardized sections:
 ### 1. Executive Summary
- Brief overview of cost comparison between current and target cities
- Key financial impact highlights
- Primary recommendation (relocate/don't relocate)
- Estimated monthly savings or additional costs
 ### 2. User Profile Summary
- Current location details
- Target location details
- Family composition and income level
- Key preferences and requirements
### 3. Housing Cost Analysis
- **Current vs Target Rental Costs**: Detailed comparison with similar property types
- **Monthly Housing Savings/Costs**: Calculate difference and percentage change
- **Property Recommendations**: List 3-5 suitable properties with links, prices, and features
- **Utility Cost Comparison**: Water, electricity, natural gas, internet costs
 ### 4. Market Price Analysis
- The user will fill a market list and you will be provided with the total price of this market list.
-Estimate the monthly market cost based on persons in the household.(You will only do the estimation for market price analysis)
### 5. Transportation Analysis
- **Public Transportation**: You will be given the users current monthly payment of public transportation pass
and you will be given the target locations public transportation types and details analyse if the user that will use the public transportation prices are student or not 
and write the total prices for public transportation if a person uses public transportation 5 days and 2 passes a day.
- **Fuel Costs**: You will provided with the users current monthly fuel payments and target city's monthly fuel prices analyse accordingly
- **Transportation Savings/Costs**: Monthly impact on budget
### 6. Education Costs (if applicable)
- **University Fees**: You must compare the university prices based on users current semester tuition cost if it exist and  on target university's price details
- **Program-Specific Costs**: Tuition, additional fee comparison with users current university fees with target university fees
-All of the university prices are from 2024-2025 season provide this information to user
 ### 7. Financial Impact Summary
- **Total Monthly Cost Difference**: Comprehensive calculation
- **Annual Financial Impact**: Projected yearly savings or costs
### 8. Conclusions and Recommendations
- **Primary Recommendation**: Clear relocate/don't relocate advice
- **Key Decision Factors**: Most important financial considerations
- **Action Items**: Specific steps for the user to take
- **Risk Assessment**: Potential financial risks
## Writing Guidelines
 ### Tone and Style
- Use clear, jargon-free language
- Base all recommendations on given data
- Provide decisive recommendations backed by analysis
 ### Formatting Standards
- Use clear headers and subheaders for navigation
- Include numerical data in tables when appropriate
- Highlight key figures and percentages
- Use bullet points for action items and recommendations
- Ensure consistent currency formatting (Turkish Lira - TL)
### Cost Comparison Calculations
1. **Weighted Analysis**: Consider user income level when assessing impact significance
2. **Percentage Calculations**: Always provide both absolute amounts and percentage changes
### Data Handling
- **Accuracy Priority**: Verify all calculations of provided data
- **Currency Consistency**: All amounts in Turkish Lira with appropriate formatting
- **Source Attribution**: Reference All the given data sources 
## Analysis Methodology
### Cost Comparison Calculations
1. **Weighted Analysis**: Consider user income level when assessing impact significance
2. **Percentage Calculations**: Always provide both absolute amounts and percentage changes
### Recommendation Logic
- **Financial Threshold**: Recommend relocation if monthly savings exceed 10% of income or monthly costs increase by less than 5%
- **Quality of Life Factors**: Consider non-financial benefits mentioned in user preferences
- **Personal Circumstances**: Weight recommendations based on family size and life stage
## Output Format
Generate the final report as a well-structured markdown document that can be easily read and acted upon by users making relocation decisions. 
Ensure the report is comprehensive enough to serve as the primary resource for their decision-making process while being concise enough to be digestible.

Remember: Your analysis and recommendations will significantly impact major life decisions. Prioritize accuracy, clarity, and actionable insights in every report you generate.

"""
    


    def get_real_estate_price_results(self,province,district,room_filter=None):
        real_estate_prices=RealEstate()
        google_search=Search()
        search_results=google_search.search("site:emlakjet.com "+province+" "+district+" kiralık daire fiyatları")
        print(search_results)
        parsed_links=google_search.parse_search_links(search_results)
        real_estate_price_results=real_estate_prices.scrape_real_estate_async(parsed_links[0],4,room_filter)
        return real_estate_price_results
    def get_utility_price_results(self,province):

        utility_prices=UtilitiesPrices()
        return utility_prices.get_all_utility_prices(province)
    def get_education_price_reults(self,university_name,department_name):
        education_agent=EducationAgent()
        education_price_information=education_agent.generate_education_agent_response(university_name,department_name)
        return education_price_information

    def get_fuel_price_results(self,owns_vehicle,current_province,target_province,
                               fuel_tank_capacity,fuel_tank_monthly_fill_count,
                               distributor_preference,vehicle_fuel_type):
        if owns_vehicle:
            fuel_prices=FuelPrices()
            current_province_fuel_data_str=fuel_prices.fetch_fuel_prices_sync(current_province)
            target_province_fuel_data_str=fuel_prices.fetch_fuel_prices_sync(target_province)


            current_province_fuel_data = json.loads(current_province_fuel_data_str)
            target_province_fuel_data = json.loads(target_province_fuel_data_str)
            print(current_province_fuel_data)
            current_province_price, current_status = fuel_prices.extract_price_for_fuel_type(current_province_fuel_data, distributor_preference, vehicle_fuel_type)
            target_province_price, target_status = fuel_prices.extract_price_for_fuel_type(target_province_fuel_data, distributor_preference, vehicle_fuel_type)

            current_monthly_fuel_prices = current_province_price * fuel_tank_monthly_fill_count * fuel_tank_capacity
            target_city_monthly_fuel_prices = target_province_price * fuel_tank_monthly_fill_count * fuel_tank_capacity

            current_status_message = fuel_prices.get_status_message(current_status, current_province, distributor_preference, vehicle_fuel_type)
            target_status_message = fuel_prices.get_status_message(target_status, target_province, distributor_preference, vehicle_fuel_type)

            return {
                "current_province":current_province,
                "target_province":target_province,
                "current_monthly_cost": current_monthly_fuel_prices,
                "target_monthly_cost": target_city_monthly_fuel_prices,
                "current_status": current_status_message,
                "target_status": target_status_message,
                "current_price_per_liter": current_province_price,
                "target_price_per_liter": target_province_price
            }

    def get_transportation_price_results(self, province, uses_public_transportation):
        if uses_public_transportation:
            transportation_prices = TransportationPrices()
            transportation_prices_for_province = transportation_prices.get_all_transportation_prices(province)
            print(transportation_prices_for_province)
            return transportation_prices_for_province

    def get_market_price_results(self,shopping_list):
        market_prices=Market_Price_Fetcher()
        market_list_results=market_prices.processShoppingListSync(shopping_list)
        total_market_price_result=market_prices.calculateTotalPrice(market_list_results)
        return total_market_price_result


    def generate_root_llm_response(self,user_preferences,
                                   real_estate_price_results,
                                   education_price_results,
                                   fuel_price_results,
                                   transportation_price_results,
                                   market_price_results,
                                   utility_price_results,
                                   average_electricity_price_for_four_people_household,
                                   average_natural_gas_price_for_four_people_household,
                                   average_water_price_for_four_people_household):
        response=self.generate_response(
        "User preferences"+f"{user_preferences}"
        +"Real estate prices"+f"{real_estate_price_results},"
         "Education prices"+f"{education_price_results}"
        "Fuel prices"+f"{fuel_price_results}"+
        "Transportation prices"+f"{transportation_price_results}"
        +"Market prices"+f"{market_price_results}"
        +"Utility prices"+f"{utility_price_results}"+
        "Average electiricty price for four people household"+f"{average_electricity_price_for_four_people_household}"
        +"Average natural gas price for four people household"+f"{average_natural_gas_price_for_four_people_household}"
        +"Average water price for four people household"+f"{average_water_price_for_four_people_household}")


        return response.text

# root=RootLLM()
# print(root.get_utility_price_results("Ankara"))
# target_province="Ankara"
# current_province="Yozgat"
# district="Keçiören"
# room_filter="3+1"
# real_estate_price_results=root.get_real_estate_price_results(target_province,district,room_filter)

# university_name="Ted Üniversitesi"
# department_name="Mühendislik"
# education_price_results=root.get_education_price_reults(university_name,department_name)
#
# fuel_price_resutls=root.get_fuel_price_results(True,current_province,target_province,40,2,"Total","gasoline")
# tranportation_price_results=root.get_transportation_price_results(target_province,True)
#
# market_list=["Elma","Armut","Bir litre Su","Süt"]
# market_price_results=root.get_market_price_results(market_list)
# sample_user_preferences = {
#     "user_profile": {
#         "current_location": {
#             "city": "Istanbul",
#             "district": "Kadikoy"
#         },
#         "target_location": {
#             "city": "Ankara",
#             "district": "Cankaya"
#         },
#         "personal_details": {
#             "age": 28,
#             "family_size": 3,
#             "monthly_net_income": 15000.0
#         },
#         "current_expenses": {
#             "housing": {
#                 "monthly_rent": 4500.0,
#                 "electricity_bill": 350.0,
#                 "natural_gas_bill": 280.0,
#                 "water_bill": 120.0,
#                 "internet_bill": 100.0
#             },
#             "transportation": {
#                 "uses_public_transportation": True,
#                 "is_the_user_student": False,
#                 "public_transport_monthly_pass": 200.0,
#                 "parking_fees": 150.0
#             },
#             "education": {
#                 "wants_education_analysis": True,
#                 "target_university": "Middle East Technical University",
#                 "department_name": "Computer Engineering",
#                 "current_tuition_semester": 2500.0
#             },
#             "other_expenses": {
#                 "gym_membership": 250.0,
#                 "entertainment_monthly": 800.0,
#                 "clothing_monthly": 400.0,
#                 "healthcare_monthly": 300.0,
#                 "subscriptions_monthly": 150.0,
#                 "travel_vacation_monthly": 500.0
#             }
#         },
#         "housing_preferences": {
#             "preferred_housing_type": "apartment",
#             "number_of_rooms": "2+1"
#         },
#         "vehicle_ownership": {
#             "owns_vehicle": True,
#             "vehicle_type": "sedan",
#             "fuel_tank_capacity": "50L",
#             "fuel_tank_monthly_fill_count": 3,
#             "distributor_preference": "Shell",
#             "vehicle_fuel_type": "gasoline"
#         },
#         "shopping_preferences": {
#             "grocery_list": [
#                 {
#                     "category": "dairy",
#                     "items": ["milk", "yogurt", "cheese"],
#                     "preferred_brands": ["Pinar", "Eker"]
#                 },
#                 {
#                     "category": "meat",
#                     "items": ["chicken", "beef", "fish"],
#                     "preferred_brands": ["Banvit", "Namet"]
#                 },
#                 {
#                     "category": "fruits_vegetables",
#                     "items": ["apples", "bananas", "tomatoes", "onions"],
#                     "preferred_brands": ["local market"]
#                 },
#                 {
#                     "category": "grains",
#                     "items": ["bread", "rice", "pasta"],
#                     "preferred_brands": ["Uno", "Tamek"]
#                 },
#                 {
#                     "category": "beverages",
#                     "items": ["tea", "coffee", "water"],
#                     "preferred_brands": ["Caykur", "Kurukahveci", "Erikli"]
#                 }
#             ]
#         }
#     }
# }
# print(root.generate_root_llm_response(sample_user_preferences,real_estate_price_results,education_price_results,fuel_price_resutls,tranportation_price_results,market_price_results))