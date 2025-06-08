import requests
from bs4 import BeautifulSoup
import re
import time
import json
import datetime
import asyncio
from concurrent.futures import ThreadPoolExecutor
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class RealEstate:
    def __init__(self, max_workers=5):
        """
        Initialize with maximum number of concurrent workers
        """
        self.max_workers = max_workers

    def create_driver(self):
        """
        Create a new Chrome driver instance with optimized settings for async operation
        """
        chrome_options = Options()
        chrome_options.add_argument('--headless')
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-dev-shm-usage')
        chrome_options.add_argument('--disable-gpu')
        chrome_options.add_argument('--disable-logging')
        chrome_options.add_argument('--disable-extensions')
        chrome_options.add_argument('--disable-web-security')
        chrome_options.add_argument('--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36')

        return webdriver.Chrome(options=chrome_options)

    def scrape_single_page(self, page_data):
        """
        Scrape a single page - designed to run in a separate thread
        Returns tuple: (page_num, properties_list)
        """
        page_num, url = page_data
        driver = None

        try:
            driver = self.create_driver()
            wait = WebDriverWait(driver, 10)

            print(f"🔄 Scraping page {page_num}: {url}")

            driver.get(url)
            time.sleep(2)  # Reduced wait time for better performance

            # Wait for page to load
            wait.until(EC.presence_of_element_located((By.TAG_NAME, "body")))
            time.sleep(1)

            page_properties = []

            # Try multiple selectors to find property containers
            property_containers = []
            selectors_to_try = [
                "[class*='styles_locationWrapper']",
                "[class*='property']",
                "[class*='listing']",
                "[class*='styles_priceContent']",
                "div[class*='styles_']",
                ".property-item",
                ".listing-item"
            ]

            for selector in selectors_to_try:
                containers = driver.find_elements(By.CSS_SELECTOR, selector)
                if containers:
                    # Filter containers that actually contain price information
                    valid_containers = []
                    for container in containers:
                        price_elements = container.find_elements(By.CSS_SELECTOR,
                                                                 "[class*='price'], span[class*='styles_price']")
                        if price_elements:
                            valid_containers.append(container)

                    if valid_containers:
                        property_containers = valid_containers
                        print(
                            f"✅ Page {page_num}: Found {len(property_containers)} properties using selector: {selector}")
                        break

            if not property_containers:
                print(f"⚠️  Page {page_num}: No property containers found")
                return (page_num, [])

            # Extract data from each property container
            for container in property_containers:
                try:
                    property_data = {'page': page_num}

                    # Extract property link
                    property_link = None
                    link_selectors = [
                        "a[href*='/ilan/']",
                        "a[href*='emlakjet.com']",
                        "a",
                    ]

                    for link_selector in link_selectors:
                        link_elements = container.find_elements(By.CSS_SELECTOR, link_selector)
                        for link_elem in link_elements:
                            href = link_elem.get_attribute('href')
                            if href and '/ilan/' in href:
                                property_link = href
                                break
                        if property_link:
                            break

                    # Try onclick or parent elements if no direct link found
                    if not property_link:
                        try:
                            onclick = container.get_attribute('onclick')
                            if onclick and 'ilan' in onclick:
                                link_match = re.search(r'/ilan/[^"\']+', onclick)
                                if link_match:
                                    property_link = f"https://www.emlakjet.com{link_match.group()}"

                            if not property_link:
                                parent = container.find_element(By.XPATH, "./..")
                                parent_links = parent.find_elements(By.CSS_SELECTOR, "a[href*='/ilan/']")
                                if parent_links:
                                    property_link = parent_links[0].get_attribute('href')
                        except:
                            pass

                    property_data['property_link'] = property_link if property_link else 'N/A'

                    # Extract price
                    price_found = False
                    price_selectors = [
                        "[class*='styles_price']",
                        "[class*='price']",
                        "span[class*='8Z_QS']",
                        "span"
                    ]

                    for price_selector in price_selectors:
                        price_elements = container.find_elements(By.CSS_SELECTOR, price_selector)
                        for price_elem in price_elements:
                            price_text = price_elem.text.strip()
                            if re.search(r'\d+[.,]?\d*\s*(TL|₺)', price_text) or re.search(r'\d+\.\d{3}', price_text):
                                property_data['price_raw'] = price_text

                                # Handle multiple prices - take first one
                                if '\n' in price_text:
                                    first_price_line = price_text.split('\n')[0].strip()
                                    property_data['price_raw'] = first_price_line
                                    price_text = first_price_line

                                # Clean price
                                price_clean = re.sub(r'[^\d.,]', '', price_text).replace(',', '')
                                if price_clean:
                                    property_data['price_clean'] = price_clean
                                    price_found = True
                                    break
                        if price_found:
                            break

                    if not price_found:
                        continue

                    # Extract location and room information
                    all_text = container.text.strip()
                    lines = [line.strip() for line in all_text.split('\n') if line.strip()]

                    temp_location = None
                    temp_rooms = None

                    # Try location selectors
                    location_selectors = [
                        "[class*='quickinfo']",
                        "[class*='location']",
                        "[class*='styles_quickinfoWrapper']",
                        "div[class*='styles_']"
                    ]

                    for loc_selector in location_selectors:
                        location_elements = container.find_elements(By.CSS_SELECTOR, loc_selector)
                        for loc_elem in location_elements:
                            loc_text = loc_elem.text.strip()
                            if loc_text and not re.search(r'\d+[.,]?\d*\s*(TL|₺)', loc_text):
                                if ('m²' in loc_text or 'kat' in loc_text.lower()) and (
                                        '+' in loc_text and any(char.isdigit() for char in loc_text)):
                                    temp_rooms = loc_text
                                elif 'mahallesi' in loc_text.lower() or 'emlâk' in loc_text.lower():
                                    temp_location = loc_text
                                break
                        if temp_location and temp_rooms:
                            break

                    # Check lines for additional info
                    for line in lines:
                        if ('m²' in line or 'kat' in line.lower()) and (
                                '+' in line and any(char.isdigit() for char in line)) and 'TL' not in line:
                            if not temp_rooms:
                                temp_rooms = line
                        elif ('mahallesi' in line.lower() or 'emlâk' in line.lower()) and 'TL' not in line:
                            if not temp_location:
                                temp_location = line

                    property_data['location'] = temp_location if temp_location else 'N/A'
                    property_data['rooms'] = temp_rooms if temp_rooms else 'N/A'

                    if property_data.get('price_clean'):
                        page_properties.append(property_data)

                except Exception as e:
                    continue

            print(f"✅ Page {page_num}: Extracted {len(page_properties)} properties")
            return (page_num, page_properties)

        except Exception as e:
            print(f"❌ Error scraping page {page_num}: {e}")
            return (page_num, [])
        finally:
            if driver:
                driver.quit()

    async def scrape_with_selenium_async(self, base_url, max_pages=5):
        """
        Async scraping of multiple pages using ThreadPoolExecutor
        """
        # Prepare all page URLs
        page_urls = []
        for page_num in range(1, max_pages + 1):
            if page_num == 1:
                url = base_url
            else:
                if '?' in base_url:
                    url = f"{base_url}&sayfa={page_num}"
                else:
                    url = f"{base_url}?sayfa={page_num}"
            page_urls.append((page_num, url))

        print(f"🚀 Starting async scraping of {max_pages} pages...")

        # Use ThreadPoolExecutor to run Selenium in separate threads
        loop = asyncio.get_event_loop()

        with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
            # Submit all page scraping tasks
            tasks = [
                loop.run_in_executor(executor, self.scrape_single_page, page_data)
                for page_data in page_urls
            ]

            # Wait for all tasks to complete
            results = await asyncio.gather(*tasks, return_exceptions=True)

        # Process results
        all_properties = []
        successful_pages = 0

        for result in results:
            if isinstance(result, Exception):
                print(f"❌ Task failed with exception: {result}")
                continue

            page_num, properties = result
            if properties:
                all_properties.extend(properties)
                successful_pages += 1
            else:
                print(f"⚠️  Page {page_num} returned no properties")

        print(f"🎉 Async scraping completed!")
        print(f"✅ Successfully scraped {successful_pages}/{max_pages} pages")
        print(f"📊 Total properties found: {len(all_properties)}")

        return all_properties

    def clean_and_analyze_prices(self, properties, room_filter=None):
        """
        Clean price data and prepare for JSON output
        Filters out properties with prices over 1,000,000 TL
        Optionally filters by room size
        """
        cleaned_properties = []
        excluded_count = 0
        room_excluded_count = 0

        for prop in properties:
            cleaned_prop = {}

            # Copy all original data except intermediate fields
            for key, value in prop.items():
                if key not in ['price_clean']:
                    cleaned_prop[key] = value

            # Clean and process price
            if 'price_clean' in prop:
                price_str = prop['price_clean'].replace('.', '').replace(',', '')
                try:
                    price_num = float(price_str)

                    # Filter out prices over 1 million TL
                    if price_num > 1000000:
                        excluded_count += 1
                        continue

                    cleaned_prop['price_numeric'] = price_num
                except ValueError:
                    cleaned_prop['price_numeric'] = None

            # Ensure all fields have values
            cleaned_prop['location'] = cleaned_prop.get('location', 'N/A')
            cleaned_prop['rooms'] = cleaned_prop.get('rooms', 'N/A')
            cleaned_prop['page'] = cleaned_prop.get('page', 1)

            # Apply room filter if specified
            if room_filter:
                property_rooms = cleaned_prop.get('rooms', 'N/A')
                room_found = False

                if room_filter.lower() in property_rooms.lower():
                    room_found = True

                if not room_found and room_filter.lower() in cleaned_prop.get('location', '').lower():
                    room_found = True

                if not room_found:
                    room_excluded_count += 1
                    continue

            cleaned_properties.append(cleaned_prop)

        if excluded_count > 0:
            print(f"🚫 Excluded {excluded_count} properties with prices over 1,000,000 TL")

        if room_filter and room_excluded_count > 0:
            print(f"🏠 Room filter applied: excluded {room_excluded_count} properties")

        return cleaned_properties

    def generate_json_output(self, properties, base_url, room_filter=None):
        """
        Generate JSON output with statistics
        """
        valid_prices = [p['price_numeric'] for p in properties if
                        p.get('price_numeric') and p.get('price_numeric') <= 1000000]

        if valid_prices:
            stats = {
                "total_properties": len(properties),
                "properties_with_valid_prices": len(valid_prices),
                "price_filter": "Properties over 1,000,000 TL excluded",
                "room_filter": f"Filtered to {room_filter} rooms" if room_filter else "No room filter applied",
                "price_statistics": {
                    "average": round(sum(valid_prices) / len(valid_prices), 2),
                    "median": round(sorted(valid_prices)[len(valid_prices) // 2], 2),
                    "min": min(valid_prices),
                    "max": max(valid_prices)
                }
            }

            # Price ranges
            ranges = [
                {"label": "0-6.000 TL", "min": 0, "max": 6000},
                {"label": "6.000-8.000 TL", "min": 6000, "max": 8000},
                {"label": "8.000-10.000 TL", "min": 8000, "max": 10000},
                {"label": "10.000-20.000 TL", "min": 10000, "max": 20000},
                {"label": "20.000-30.000 TL", "min": 20000, "max": 30000},
                {"label": "30.000-50.000 TL", "min": 30000, "max": 50000},
                {"label": "50.000-100.000 TL", "min": 50000, "max": 100000},
                {"label": "100.000-200.000TL", "min": 100000, "max": 200000}
            ]

            properties_by_range = {}
            for range_info in ranges:
                range_label = range_info["label"]
                range_properties = [p for p in properties if
                                    p.get('price_numeric') and
                                    range_info["min"] <= p.get('price_numeric') < range_info["max"]]

                properties_by_range[range_label] = {
                    "count": len(range_properties),
                    "properties": range_properties
                }
        else:
            stats = {
                "total_properties": len(properties),
                "properties_with_valid_prices": 0,
                "price_filter": "Properties over 1,000,000 TL excluded",
                "room_filter": f"Filtered to {room_filter} rooms" if room_filter else "No room filter applied",
                "price_statistics": None
            }
            properties_by_range = {}

        # Extract location from URL
        location = "Unknown"
        if "emlakjet.com" in base_url:
            url_parts = base_url.split("/")
            if len(url_parts) > 3:
                location = url_parts[-1].split("?")[0].replace("-", " ").title()

        json_data = {
            "real_estate_rental_prices": {
                "timestamp": datetime.datetime.now().isoformat(),
                "source_url": base_url,
                "location": location,
                "property_type": "Rental Properties",
                "price_filter": "Excludes properties over 1,000,000 TL",
                "room_filter": f"Filtered to {room_filter} rooms" if room_filter else "No room filter applied",
                "pages_scraped": len(set([p.get('page', 1) for p in properties])),
                "scraping_method": "Async Multi-threaded"
            },
            "statistics": stats,
            "properties_by_price_range": properties_by_range
        }

        return json_data

    async def parse_real_estate_results_async(self, url, max_pages=5, room_filter=None, max_workers=5):
        """
        Main async scraping function

        Args:
            url (str): Emlakjet URL to scrape
            max_pages (int): Number of pages to scrape
            room_filter (str): Room size filter (e.g., "3+1", "2+1")
            max_workers (int): Maximum number of concurrent workers
        """
        if not url:
            print("❌ No URL provided!")
            return None

        if "emlakjet.com" not in url:
            print("❌ Please provide a valid Emlakjet URL!")
            return None

        # Set max workers
        self.max_workers = max_workers

        print(f"🚀 Starting async scraping: {url}")
        print(f"📄 Pages to scrape: {max_pages}")
        print(f"⚡ Max concurrent workers: {max_workers}")
        if room_filter:
            print(f"🏠 Room filter: {room_filter}")
        print("🔄 Processing...\n")

        start_time = time.time()

        # Use async Selenium scraping
        properties = await self.scrape_with_selenium_async(url, max_pages=max_pages)

        scraping_time = time.time() - start_time
        print(f"⏱️  Scraping completed in {scraping_time:.2f} seconds")

        if properties:
            print(f"✅ Found {len(properties)} properties total")

            # Clean and prepare data
            cleaned_properties = self.clean_and_analyze_prices(properties, room_filter=room_filter)

            if cleaned_properties:
                # Generate JSON output
                json_data = self.generate_json_output(cleaned_properties, url, room_filter=room_filter)

                # Add performance metrics
                # json_data["performance_metrics"] = {
                #     "total_scraping_time_seconds": round(scraping_time, 2),
                #     "pages_per_second": round(max_pages / scraping_time, 2),
                #     "properties_per_second": round(len(properties) / scraping_time, 2),
                #     "concurrent_workers_used": max_workers
                # }

                print("\n" + "=" * 80)
                print("📋 ASYNC JSON OUTPUT:")
                print("=" * 80)
                print(json.dumps(json_data, ensure_ascii=False, indent=2))
                print("=" * 80)

                return json_data
            else:
                print("❌ Could not parse any valid property data")
                if room_filter:
                    print(f"   • No properties found matching room filter: {room_filter}")
        else:
            print("❌ No properties found")

        return None


    # Synchronous wrapper function for easy usage
    def scrape_real_estate_async(self,url, max_pages=5, room_filter=None, max_workers=5):
        """
        Synchronous wrapper for the async scraping function
        """
        scraper = RealEstate(max_workers=max_workers)

        # Run the async function
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)

        try:
            result = loop.run_until_complete(
                scraper.parse_real_estate_results_async(url, max_pages, room_filter, max_workers)
            )
            return result
        finally:
            loop.close()


# # Example usage:
# if __name__ == "__main__":
#         # Example 1: Basic async scraping
#     # result = scrape_real_estate_async("https://www.emlakjet.com/kiralik-konut/ankara", 5)
#     #
#     # Example 2: With room filter and custom worker count
#     # result = scrape_real_estate_async(
#     #     "https://www.emlakjet.com/kiralik-konut/ankara",
#     #     max_pages=10,
#     #     max_workers=10
#     # )
#
# #     print("Async Real Estate Scraper ready!")
#     print("Usage: scrape_real_estate_async(url, max_pages, room_filter, max_workers)")
#     print("Example: scrape_real_estate_async('https://www.emlakjet.com/kiralik-konut/ankara', 5, '3+1', 5)")