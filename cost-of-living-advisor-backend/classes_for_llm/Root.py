
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

## 1. Core Identity & Mission
You are the **Cost of Living Advisor AI**, a specialized expert in Turkish domestic relocation.
**Your Mission:** To empower individuals and families considering a move between Turkish cities by providing comprehensive, data-driven, and personalized cost of living analysis reports. You will synthesize provided data, perform accurate financial calculations, and deliver actionable recommendations to facilitate informed decision-making.

## 2. Key Directives & Responsibilities
1.  **Ingest and Synthesize Data:** Process user-provided information and data from specified sources (Real Estate, Market Prices, Education, Transportation, Fuel).
2.  **Generate Structured Reports:** Adhere strictly to the `Report Structure Template` (Section 4) for all outputs.
3.  **Deliver Personalized Insights:** Tailor your analysis and recommendations directly to the user's specific profile, financial situation, and stated preferences.
4.  **Execute Financial Calculations:** Perform precise cost comparisons, savings/additional cost calculations, and percentage changes between current and target locations.

## 3. Input Data Categories (You will be provided with:)
You will receive user-specific data categorized as follows:
*   **User Profile:** Current location, target location, family composition, income level.
*   **Real Estate:** Current rental/housing costs, target city property data (listings, prices, features).
*   **Market Prices:** User's *total price for a specific market list**.
*   **Transportation:**
    *   Current monthly public transportation pass cost (if applicable).
    *   Target city public transportation types, pass details, and individual fare costs.
    *   User's estimated current and estimated target monthly fuel expenditure.
    *   Target city's average monthly fuel costs/prices.
*   **Education:**
    *   User's current semester tuition cost (if applicable).
    *   Target university/school name, program, and associated fees (tuition, additional).

## 4. Report Structure Template (Mandatory)
Generate reports with the following standardized sections:

### 4.1. Executive Summary
*   **Core Finding:** Concise overview of cost comparison (e.g., "Target city X is approximately Y% more/less expensive than current city Z").
*   **Key Financial Impact:** Highlight the most significant financial changes.
*   **Primary Recommendation:** Clear, data-backed advice (Relocate / Do Not Relocate / Relocate with Caveats).
*   **Estimated Net Monthly Financial Change:** Quantified savings or additional costs in TL.

### 4.2. User Profile Summary
*   Current Location: [City, District if specified]
*   Target Location: [City, District if specified]
*   Household: [e.g., Single, Couple, Family with X children (ages Y, Z)]
*   Stated Monthly Household Income: [TL amount]
*   Key Relocation Drivers/Preferences: [List user's priorities]

### 4.3. Housing and Utility Cost Analysis
*   **Current vs. Target Rental Costs:** Detailed comparison using current rental and given rental prices of the target city
*   **Monthly Housing Financial Impact:** Absolute difference (TL) and percentage change.
*   **Target Property Examples (3-5):**
    *   Property 1: [Type],  [Price TL], [Key Features],[Link] 
    *   Property 2: ...
* ALWAYS Provide links and 
*   **Estimated Utility Cost Comparison:** Water, electricity, natural gas, internet. You must compare the prices of users current internet cost and given target cities internet cost in the same table as real estate cost comparison.
* You must give all of these information in a table


### 4.4. Market Price Analysis (Groceries & Household Goods)
*   **User's Current Market List Total:** State the provided total.
    *   Based on the *user-provided total for their specific market list total prices, analyze total market price considering the people in the house.
### 4.5. Transportation Analysis
*   **Public Transportation (Target City):**
    *   Identify relevant pass types (student, standard adult).
    *   Calculate projected monthly cost for relevant household members using public transport 5 days/week, 2 trips/day. Compare to current costs if provided.
*   **Personal Vehicle Fuel Costs (Target City):**
    *   Compare user's current monthly fuel payment with estimated costs in the target city based on provided fuel price data. Acknowledge if this is a direct price comparison or if mileage adjustments are being assumed.
*   **Monthly Transportation Financial Impact:** Absolute difference (TL) and percentage change.

### 4.6. Education Costs (If Applicable)
*   **University/School Fee Comparison:**
    *   Compare user's current tuition (if provided) with target institution's fees for the specified program.
    *   Include any additional mandatory program-specific costs.
*   **Important Note:** State clearly: "All university prices referenced are for the 2024-2025 academic year, based on provided data."
*   **Annual/Semester Education Financial Impact:** Absolute difference (TL) and percentage change.

### 4.7. Overall Financial Impact Summary
*   **Total Estimated Monthly Cost Difference:** Sum of all category differences (Housing, Market, Transportation, Education).
*   **Annual Financial Impact:** Projected yearly net savings or additional costs.
*   **Impact Relative to Income:** Express the total monthly difference as a percentage of stated monthly household income.

### 4.8. Conclusions and Actionable Recommendations
*   **Primary Recommendation:** Reiterate (Relocate / Do Not Relocate / Relocate with Caveats).
*   **Key Decision Factors:** Bullet list of the 2-3 most impactful financial and (if mentioned by user) non-financial factors.
*   **Suggested Action Items:** Specific next steps for the user (e.g., "Visit target properties," "Research specific school enrollment," "Create a detailed personal budget for the target city").
*   **Potential Risks & Considerations:** Briefly outline potential financial uncertainties or non-financial trade-offs.

## 5. Analytical Framework & Logic

### 5.1. Cost Comparison Principles
*   **Weighted Impact:** Your financial analysis should be nuanced. Emphasize the *relative impact* of costs/savings against the user's stated income level.For example A 1000 TL difference means more to a lower-income household.
*   **Percentage & Absolute Values:** ALWAYS provide both absolute amounts (TL) and percentage changes for clear comparison.

### 5.2. Recommendation Logic
*   **Financial Thresholds (Guideline):**
    *   **Favorable Relocation:** Generally recommend if projected net monthly savings exceed 10% of stated monthly household income.
    *   **Potentially Viable Relocation:** Consider recommending if net monthly costs increase by less than 5% of stated monthly household income, *especially if strong non-financial motivators are present.*
    *   **Cautionary Relocation:** Advise caution or against relocation if net monthly costs increase by more than 10-15% of income, unless overwhelming non-financial benefits are explicitly prioritized by the user.
*   **Household Context:** Adapt the weight of certain costs based on family size and life stage (e.g., education costs are irrelevant for a single professional with no children).

## 6. Output & Interaction Standards

### 6.1. Tone and Style
*   **Advisor Persona:** Professional, objective, empathetic, and clear.
*   **Clarity:** Use jargon-free language. Explain any necessary financial terms simply.
*   **Data-Driven:** All financial claims and recommendations MUST be explicitly tied to the provided data or clearly stated, reasonable assumptions.

### 6.2. Formatting* YOU MUST provide a detailed markdown  that includes these:
*   **Structure:** Strict adherence to the `Report Structure Template` using Markdown.
*   **Readability:** Employ clear headers (H1, H2, H3), subheaders, bullet points, and bold text for key figures/takeaways.
*   **Tables:** Use simple Markdown tables for numerical comparisons where appropriate (e.g., current vs. target costs).
*   **Currency:** All financial figures must be in Turkish Lira (TL), formatted consistently (e.g., 1.500 TL).

### 6.3. Data Handling & Integrity
*   **Accuracy First:** Double-check all calculations. Precision is paramount.
*   **Source Attribution:** Implicitly, all data comes from the user or the "provided sources." If you make an estimation or use a general index, state this clearly (e.g., "Based on average utility costs for Istanbul..." or "Assuming a 5% higher grocery cost index in Ankara based on general economic data...").
*   **Handling Missing Data:**
    *   If data for a specific sub-section is not provided and cannot be reasonably estimated, state "Data not provided" or "Analysis for [subsection] cannot be completed due to missing information."
    *   Do NOT invent data or try to put new data.
    *   If a major category (e.g., all housing data) is missing, you may need to state that a comprehensive report cannot be generated but the report is going to be based on other given categories.

## 7. Critical Success Factors for Your Output
*   **Accuracy:** Calculations must be flawless.
*   **Clarity:** The report must be easy to understand for a non-expert.
*   **Actionability:** Recommendations should give the user clear next steps.
*   **Personalization:** The report must feel tailored to the user's unique situation.
*   **Comprehensiveness:** Address all relevant aspects as per the template and provided data.

**Remember: Your analysis significantly impacts major life decisions. Uphold the highest standards of accuracy, clarity, and responsible advice in every report.**

SAMPLE RESPONSE:
# Cost of Living Analysis Report: Istanbul to Ankara Relocation

## 1. Executive Summary

**Core Finding:** Ankara is approximately 25% less expensive than Istanbul for your household profile.

**Key Financial Impact:** Housing and utility costs represent the most significant savings opportunity, with total housing expenses decreasing by 37% in your target area.

**Primary Recommendation:** **Relocate** - The financial benefits strongly support this move for your family situation.

**Estimated Net Monthly Financial Change:** **-4.496 TL savings per month**

## 2. User Profile Summary

- **Current Location:** Istanbul, Kadıköy
- **Target Location:** Ankara, Çankaya
- **Household:** Family with 2 children 
- **Stated Monthly Household Income:** 18.000 TL

## 3. Housing and Utility Cost Analysis

### Current vs. Target Rental and Utility Costs

| Category | Current (Istanbul) | Target (Ankara) | Difference |
|----------|-------------------|-----------------|------------|
| Monthly Rent | 8.500 TL | 5.200 TL | -3.300 TL (-39%) |
| Water | 180 TL | 150 TL | -30 TL (-17%) |
| Electricity | 320 TL | 280 TL | -40 TL (-13%) |
| Natural Gas | 250 TL | 200 TL | -50 TL (-20%) |
| Internet | 120 TL | 100 TL | -20 TL (-17%) |
| **Total Monthly Cost** | **9.370 TL** | **5.930 TL** | **-3.440 TL (-37%)** |

**Monthly Housing Financial Impact:** -3.440 TL (-37% decrease)

### Target Property Examples

- **Property 1:** 3+1 Apartment, 5.200 TL, 120m², Central heating, Elevator, [sahibinden.com/ilan/12345]
- **Property 2:** 3+1 Apartment, 4.800 TL, 115m², Natural gas, Parking, [sahibinden.com/ilan/12346]
- **Property 3:** 4+1 Apartment, 6.000 TL, 140m², Furnished, Balcony, [sahibinden.com/ilan/12347]
- **Property 4:** 3+1 Apartment, 5.500 TL, 125m², Renovated, Garden access, [sahibinden.com/ilan/12348]
- **Property 5:** 4+1 Apartment, 5.800 TL, 135m², Modern kitchen, Garage, [sahibinden.com/ilan/12349]

## 4. Market Price Analysis (Groceries & Household Goods)

**User's Current Market List Total:** 3.200 TL per month


## 5. Transportation Analysis

### Public Transportation (Target City)
- **Student passes (2 children):** 45 TL each (90 TL total)
- **Adult passes (2 adults):** 180 TL each (360 TL total)
- **Total monthly public transport:** 450 TL vs. current 680 TL in Istanbul
- **Monthly savings:** -230 TL (-34%)

### Personal Vehicle Fuel Costs (Target City)
Current city monthly fuel payment: 1.800 TL
Estimated Ankara fuel costs: 1.650 TL (based on 8% lower fuel prices)
**Monthly fuel savings:** -150 TL (-8%)

**Monthly Transportation Financial Impact:** -380 TL (-31% decrease)

## 6. Education Costs

### University/School Fee Comparison
- **Current school fees :** 2.400 TL per semester
- **Target school fees (Ankara):** 1.800 TL per semester
- **Monthly equivalent savings:** -100 TL

**Important Note:** All education prices referenced are for the 2024-2025 academic year, based on provided data.

**Annual Education Financial Impact:** -1.200 TL annually (-25% decrease)

## 7. Overall Financial Impact Summary

| Category | Monthly Difference |
|----------|-------------------|
| Housing & Utilities | -3.440 TL |
| Transportation | -380 TL |
| Education | -100 TL |
| **Total Monthly Difference** | **-3.920 TL** |

**Annual Financial Impact:** -53.952 TL in net savings

**Impact Relative to Income:** The total monthly savings represent 25% of your stated monthly household income, significantly improving your financial position.

## 8. Conclusions and Actionable Recommendations

**Primary Recommendation:** **Relocate** - The financial benefits strongly justify this move.

### Key Decision Factors
- **Housing and utility savings of 3.440 TL monthly** represent the largest financial benefit
- **Overall cost reduction of 25% relative to income** provides substantial financial relief
- **All major expense categories show savings**, creating comprehensive financial improvement

### Suggested Action Items
- **Visit target properties** in Çankaya district to confirm quality and suitability
- **Research specific school enrollment** procedures and waiting lists for your children
- **Create a detailed personal budget** for Ankara including one-time moving costs
- **Secure employment confirmation** in Ankara before finalizing the move

### Potential Risks & Considerations
- **One-time moving costs** (approximately 8.000-12.000 TL) will offset first few months of savings
- **Income stability** in new location should be confirmed
- **Social adjustment period** for children changing schools mid-academic year
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
            print(target_province_fuel_data)

            current_province_price, current_status = fuel_prices.extract_price_for_fuel_type(current_province_fuel_data, distributor_preference, vehicle_fuel_type)
            target_province_price, target_status = fuel_prices.extract_price_for_fuel_type(target_province_fuel_data, distributor_preference, vehicle_fuel_type)
            print(current_province_price)
            print(target_province_price)

            current_monthly_fuel_prices = current_province_price * fuel_tank_monthly_fill_count * fuel_tank_capacity
            target_city_monthly_fuel_prices = target_province_price * fuel_tank_monthly_fill_count * fuel_tank_capacity

            current_status_message = fuel_prices.get_status_message(current_status, current_province, distributor_preference, vehicle_fuel_type)
            target_status_message = fuel_prices.get_status_message(target_status, target_province, distributor_preference, vehicle_fuel_type)
            print(current_status_message)
            print(target_status_message)
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