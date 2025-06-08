import re
import json
import os
import asyncio
# from market_crawl_tool import *
# from market_search_tool import *
import statistics

from classes_for_llm.market_prices.market_crawl_tool import fetchSiteHTML
from classes_for_llm.market_prices.market_search_tool import search_product


class Market_Price_Fetcher():

    status = "IDLE"

    def __init__(self):
        self.status = "IDLE"

    def remove_outliers(self,values):
        # If we have fewer than 2 data points, we can't calculate quartiles
        # Just return the original values
        if len(values) < 2:
            return values
            
        values_sorted = sorted(values)
        q1 = statistics.quantiles(values_sorted, n=4)[0]
        q3 = statistics.quantiles(values_sorted, n=4)[2]
        iqr = q3 - q1
        lower_bound = q1 - 1.5 * iqr
        upper_bound = q3 + 1.5 * iqr
        return [x for x in values if lower_bound <= x <= upper_bound]

    def calculate_filtered_averages(self,products):
        prices = [item["price"] for item in products if isinstance(item.get("price"), (int, float))]
        unit_prices = [item["unit_price"] for item in products if isinstance(item.get("unit_price"), (int, float))]

        filtered_prices = self.remove_outliers(prices)
        filtered_unit_prices = self.remove_outliers(unit_prices)

        avg_price = sum(filtered_prices) / len(filtered_prices) if filtered_prices else 0
        avg_unit_price = sum(filtered_unit_prices) / len(filtered_unit_prices) if filtered_unit_prices else 0

        return avg_price, avg_unit_price

    def extract_quantity_and_unit(self, name):
        name = name.lower()
        name = name.replace(",", ".")

        # 1. Match "250 g", "1.5 kg"
        match = re.search(r'(\d+(?:\.\d+)?)\s*(kg|g)', name)
        if match:
            qty = float(match.group(1))
            unit = match.group(2)
            return (qty if unit == "kg" else qty / 1000, "kg")

        # 2. Match "1 lt", "500 ml"
        match = re.search(r'(\d+(?:\.\d+)?)\s*(lt|ml)', name)
        if match:
            qty = float(match.group(1))
            unit = match.group(2)
            return (qty if unit == "lt" else qty / 1000, "lt")

        # 3. Match "adet" if no quantity
        if "adet" in name:
            return (1, "adet")

        # 4. Match "30'lu", "6'lı", "12 li", etc.
        match = re.search(r"(\d+)\s*[''`´]?\s*(lu|lı|li)", name)
        if match:
            qty = int(match.group(1))
            return (qty, "adet")

        # 5. Match "2 x 10'lu", "3 x 6'lı"
        match = re.search(r"(\d+)\s*[xX×]\s*(\d+)", name)
        if match:
            qty = int(match.group(1)) * int(match.group(2))
            return (qty, "adet")

        # 6. Fallbacks
        if "kg" in name:
            return (1.0, "kg")
        if "lt" in name:
            return (1.0, "lt")

        return (None, None)

    async def generateProductJSON(self,product_name):

        self.status = "SEARCHING"

        link = search_product(product_name)["organic"][0]["link"]
        
        # Add sorting parameter to get cheapest to most expensive products
        if link.endswith('.html'):
            link = link[:-5] + ',1,2.html'
        else:
            link = link + ',1,2'

        self.status = "CRAWLING"

        # Step 1: Load the HTML file
        html = await fetchSiteHTML(link)

        self.status = "EXTRACTING JSON"

        # Step 2: Extract window.__remixContext JSON
        match = re.search(r'window\.__remixContext\s*=\s*(\{.*?\})\s*;\s*</script>', html, re.DOTALL)
        if not match:
            print("Could not find window.__remixContext.")
            return []

        json_str = match.group(1)

        # Step 3: Parse the JSON
        try:
            data = json.loads(json_str)
        except json.JSONDecodeError as e:
            print(f"Failed to decode JSON: {e}")
            return []

        # Step 4: Try to get products list
        try:
            products = data["state"]["loaderData"]["routes/$"]["generalData"]["productList"]["products"]
        except KeyError:
            print("Could not locate productList.products in JSON.")
            return []

        self.status = "MAKING JSON LIST"

        # Step 5: Process product info and save
        product_infos = []
        for product in products:
            name = product.get("name", "N/A")
            price = product.get("priceNew") or product.get("price")
            link = product.get("url") or product.get("productUrl")

            # Extract weight and calculate unit price

            (weight_kg, unit_type) = self.extract_quantity_and_unit(name)
            calc_unit_price = round(price / weight_kg, 2) if weight_kg and price else None

            prod = {
                "name": name,
                "price": price,
                "link": "https://www.akakce.com" + link if link is not None else "N/A"
            }

            prod["unit_price"] = calc_unit_price
            prod["unit_type"] = unit_type
            prod["unit_weight"] = weight_kg

            product_infos.append(prod)

        return product_infos

    async def getAvarageOfProduct(self, product_name):

        product_infos = await self.generateProductJSON(product_name)

        avg_price, avg_unit_price = self.calculate_filtered_averages(product_infos)

        return avg_price, avg_unit_price

    async def processShoppingList(self, list):

        # Create tasks for all products to run concurrently
        tasks = []
        for product in list:
            tasks.append(self.getAvarageOfProduct(product))

        # Wait for all tasks to complete
        results = await asyncio.gather(*tasks)

        # Build the response data
        prices = []
        for i, product in enumerate(list):
            avg_price, avg_unit_price = results[i]
            
            data = {
                "name": product,
                "avarage_price": avg_price,
                "avarage_unit_price": avg_unit_price
            }
            prices.append(data)

        self.status = "IDLE"
        return prices

    def calculateTotalPrice(self, shopping_list_results):
        """
        Calculate the total price from processShoppingList results.
        
        Args:
            shopping_list_results: List of dictionaries from processShoppingList method
            
        Returns:
            float: Total price of all products
        """
        total_price = 0.0
        
        for product in shopping_list_results:
            avg_price = product.get("avarage_price", 0)
            if isinstance(avg_price, (int, float)) and avg_price > 0:
                total_price += avg_price
                
        return round(total_price, 2)

    def processShoppingListSync(self, shopping_list):
        """
        Synchronous wrapper for processShoppingList async method.
        
        Args:
            shopping_list: List of product names to process
            
        Returns:
            List of dictionaries with product price information
        """
        return asyncio.run(self.processShoppingList(shopping_list))

    # def calculateTotalUnitPrice(self, shopping_list_results):
    #     """
    #     Calculate the total average unit price from processShoppingList results.
    #
    #     Args:
    #         shopping_list_results: List of dictionaries from processShoppingList method
    #
    #     Returns:
    #         float: Total average unit price of all products
    #     """
    #     total_unit_price = 0.0
    #
    #     for product in shopping_list_results:
    #         avg_unit_price = product.get("avarage_unit_price", 0)
    #         if isinstance(avg_unit_price, (int, float)) and avg_unit_price > 0:
    #             total_unit_price += avg_unit_price
    #
    #     return round(total_unit_price, 2)

# Example usage
async def main():
    fetcher = Market_Price_Fetcher()
    result = await fetcher.processShoppingList(["bir kg salatalık"])
    print(json.dumps(result, indent=4, ensure_ascii=False))
    
    # Calculate total price
    total_price = fetcher.calculateTotalPrice(result)
    print(f"\nTotal Price: {total_price} TL")
    
    # Calculate total unit price
    # total_unit_price = fetcher.calculateTotalUnitPrice(result)
    # print(f"Total Unit Price: {total_unit_price} TL")

if __name__ == "__main__":
    asyncio.run(main())

