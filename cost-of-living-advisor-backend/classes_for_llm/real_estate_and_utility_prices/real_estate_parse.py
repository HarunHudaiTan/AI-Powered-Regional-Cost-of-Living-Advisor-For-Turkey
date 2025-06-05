import requests
from bs4 import BeautifulSoup
import re
import time
import json
import datetime
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class RealEstate:
    def scrape_with_requests(self,url):
        """
        Basic scraping with requests - may not work if site uses JavaScript
        """
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }

        try:
            response = requests.get(url, headers=headers)
            response.raise_for_status()

            soup = BeautifulSoup(response.content, 'html.parser')

            # Find price elements based on your HTML structure
            price_spans = soup.find_all('span', class_=re.compile(r'styles_price.*'))

            prices = []
            for span in price_spans:
                price_text = span.get_text(strip=True)
                # Extract numeric value from price text
                price_match = re.search(r'[\d.,]+', price_text)
                if price_match:
                    prices.append(price_match.group())

            return prices

        except Exception as e:
            print(f"Error with requests method: {e}")
            return []

    def scrape_with_selenium(self, base_url, max_pages=5):
        """
        Advanced scraping with Selenium - handles JavaScript-rendered content
        Scrapes multiple pages using URL parameter structure
        Now includes property links extraction
        """
        # Setup Chrome options
        chrome_options = Options()
        chrome_options.add_argument('--headless')  # Run in background
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-dev-shm-usage')
        chrome_options.add_argument('--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36')

        try:
            driver = webdriver.Chrome(options=chrome_options)
            wait = WebDriverWait(driver, 10)
            all_properties = []

            for page_num in range(1, max_pages + 1):
                # Construct URL for each page
                if page_num == 1:
                    url = base_url  # First page doesn't need ?sayfa=1
                else:
                    # Check if URL already has parameters
                    if '?' in base_url:
                        url = f"{base_url}&sayfa={page_num}"
                    else:
                        url = f"{base_url}?sayfa={page_num}"

                print(f"Scraping page {page_num}: {url}")

                try:
                    driver.get(url)
                    time.sleep(3)  # Wait for page to load

                    # Wait for property listings to load
                    wait.until(EC.presence_of_element_located((By.TAG_NAME, "body")))
                    time.sleep(2)  # Additional wait for dynamic content

                    # Try multiple selectors to find property containers
                    property_containers = []

                    # Try different selector combinations
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
                                print(f"Found {len(property_containers)} properties using selector: {selector}")
                                break

                    if not property_containers:
                        print(f"No property containers found on page {page_num}")
                        # Try to get all divs and search for price patterns
                        all_elements = driver.find_elements(By.CSS_SELECTOR, "span, div")
                        price_elements = []
                        for element in all_elements:
                            text = element.text.strip()
                            if re.search(r'\d+[.,]?\d*\s*(TL|₺)', text) or re.search(r'\d+\.\d{3}', text):
                                price_elements.append(element)

                        if price_elements:
                            print(f"Found {len(price_elements)} elements with price patterns")
                            for i, elem in enumerate(price_elements[:5]):
                                print(f"  {i + 1}. {elem.text.strip()}")
                        continue

                    # Extract data from each property container
                    page_properties = 0
                    for container in property_containers:
                        try:
                            property_data = {'page': page_num}

                            # *** NEW: Extract property link ***
                            property_link = None

                            # Try to find link within the container
                            link_selectors = [
                                "a[href*='/ilan/']",  # Direct link to property detail
                                "a[href*='emlakjet.com']",  # Any emlakjet link
                                "a",  # Any link in the container
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

                            # If no link found in container, try finding parent/ancestor with link
                            if not property_link:
                                # Try to find if the container itself is clickable or has a parent link
                                try:
                                    # Check if container has onclick or data attributes that might contain the link
                                    onclick = container.get_attribute('onclick')
                                    if onclick and 'ilan' in onclick:
                                        # Extract link from onclick if present
                                        link_match = re.search(r'/ilan/[^"\']+', onclick)
                                        if link_match:
                                            property_link = f"https://www.emlakjet.com{link_match.group()}"

                                    # Check parent elements for links
                                    if not property_link:
                                        parent = container.find_element(By.XPATH, "./..")
                                        parent_links = parent.find_elements(By.CSS_SELECTOR, "a[href*='/ilan/']")
                                        if parent_links:
                                            property_link = parent_links[0].get_attribute('href')
                                except:
                                    pass

                            # Add the property link to the data
                            property_data['property_link'] = property_link if property_link else 'N/A'

                            # Extract price with multiple approaches
                            price_found = False
                            price_selectors = [
                                "[class*='styles_price']",
                                "[class*='price']",
                                "span[class*='8Z_QS']",  # From your HTML example
                                "span"
                            ]

                            for price_selector in price_selectors:
                                price_elements = container.find_elements(By.CSS_SELECTOR, price_selector)
                                for price_elem in price_elements:
                                    price_text = price_elem.text.strip()
                                    # Check if this looks like a price
                                    if re.search(r'\d+[.,]?\d*\s*(TL|₺)', price_text) or re.search(r'\d+\.\d{3}',
                                                                                                   price_text):
                                        property_data['price_raw'] = price_text

                                        # Handle multiple prices separated by newline - take only the first one
                                        if '\n' in price_text:
                                            first_price_line = price_text.split('\n')[0].strip()
                                            property_data['price_raw'] = first_price_line
                                            price_text = first_price_line

                                        # Clean price text and extract number
                                        price_clean = re.sub(r'[^\d.,]', '', price_text).replace(',', '')
                                        if price_clean:
                                            property_data['price_clean'] = price_clean
                                            price_found = True
                                            break
                                if price_found:
                                    break

                            if not price_found:
                                continue

                            # Extract all text content for details
                            all_text = container.text.strip()
                            lines = [line.strip() for line in all_text.split('\n') if line.strip()]

                            # Initialize temporary variables to hold location and room info
                            temp_location = None
                            temp_rooms = None

                            # Extract location and room information from different selectors
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
                                        # Check if this text contains room info (has + and digits) and property details
                                        if ('m²' in loc_text or 'kat' in loc_text.lower()) and (
                                                '+' in loc_text and any(char.isdigit() for char in loc_text)):
                                            temp_rooms = loc_text
                                        # Check if this text looks like a neighborhood/location name
                                        elif 'mahallesi' in loc_text.lower() or 'emlâk' in loc_text.lower():
                                            temp_location = loc_text
                                        break
                                if temp_location and temp_rooms:
                                    break

                            # Also check in all lines for location and room info
                            for line in lines:
                                # Look for room/property details (contains m², floor info, room count)
                                if ('m²' in line or 'kat' in line.lower()) and (
                                        '+' in line and any(char.isdigit() for char in line)) and 'TL' not in line:
                                    if not temp_rooms:
                                        temp_rooms = line
                                # Look for location info (neighborhood, emlak office info)
                                elif ('mahallesi' in line.lower() or 'emlâk' in line.lower()) and 'TL' not in line:
                                    if not temp_location:
                                        temp_location = line

                            # Assign the correctly identified fields
                            property_data['location'] = temp_location if temp_location else 'N/A'
                            property_data['rooms'] = temp_rooms if temp_rooms else 'N/A'

                            if property_data.get('price_clean'):
                                all_properties.append(property_data)
                                page_properties += 1

                        except Exception as e:
                            continue

                    print(f"Extracted {page_properties} properties from page {page_num}")

                    if page_properties == 0:
                        print(f"No valid properties found on page {page_num}, stopping...")
                        break

                except Exception as e:
                    print(f"Error scraping page {page_num}: {e}")
                    continue

            driver.quit()
            return all_properties

        except Exception as e:
            print(f"Error with Selenium: {e}")
            if 'driver' in locals():
                driver.quit()
            return []


    def clean_and_analyze_prices(self,properties, room_filter=None):
        """
        Clean price data and prepare for JSON output
        Filters out properties with prices over 1,000,000 TL
        Optionally filters by room size (e.g., "3+1", "2+1", "4+1")
        """
        cleaned_properties = []
        excluded_count = 0
        room_excluded_count = 0

        for prop in properties:
            cleaned_prop = {}

            # Copy all original data except intermediate fields
            for key, value in prop.items():
                if key not in ['price_clean']:  # Exclude intermediate processing fields
                    cleaned_prop[key] = value

            # Clean and process price
            if 'price_clean' in prop:
                # Remove any non-numeric characters except dots and commas
                price_str = prop['price_clean'].replace('.', '').replace(',', '')
                try:
                    price_num = float(price_str)

                    # Filter out prices over 1 million TL
                    if price_num > 1000000:
                        excluded_count += 1
                        print(f"Excluding property with price {price_num:,.0f} TL (over 1M limit)")
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
                # Check if room filter matches in any text field
                room_found = False

                # Check in rooms field
                if room_filter.lower() in property_rooms.lower():
                    room_found = True

                # Check in location field (sometimes room info is there)
                if not room_found and room_filter.lower() in cleaned_prop.get('location', '').lower():
                    room_found = True

                # If room filter specified but not found, exclude this property
                if not room_found:
                    room_excluded_count += 1
                    continue

            cleaned_properties.append(cleaned_prop)

        if excluded_count > 0:
            print(f"\n🚫 Excluded {excluded_count} properties with prices over 1,000,000 TL")

        if room_filter and room_excluded_count > 0:
            print(f"🏠 Filtered to {room_filter} rooms: excluded {room_excluded_count} properties")

        return cleaned_properties


    def generate_json_output(self,properties, base_url, room_filter=None):
        """
        Generate JSON output without saving to file
        Only includes properties under 1,000,000 TL
        Optionally filtered by room size
        """
        # Calculate statistics (only for properties under 1M TL)
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
                },
                # "price_distribution": {}
            }

            # Price ranges (adjusted for realistic rental prices)
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

            # Group properties by price ranges and collect all properties
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

                # stats["price_distribution"][range_label] = len(range_properties)
        else:
            stats = {
                "total_properties": len(properties),
                "properties_with_valid_prices": 0,
                "price_filter": "Properties over 1,000,000 TL excluded",
                "room_filter": f"Filtered to {room_filter} rooms" if room_filter else "No room filter applied",
                "price_statistics": None,
                # "price_distribution": {}
            }
            properties_by_range = {}

        # Properties per page (only counting included properties)
        page_counts = {}
        for prop in properties:
            page = prop.get('page', 'unknown')
            page_counts[f"page_{page}"] = page_counts.get(f"page_{page}", 0) + 1

        # Extract location from URL
        location = "Unknown"
        if "emlakjet.com" in base_url:
            url_parts = base_url.split("/")
            if len(url_parts) > 3:
                location = url_parts[-1].split("?")[0].replace("-", " ").title()

        # Create comprehensive JSON structure
        json_data = {
            "real_estate_rental_prices": {
                "timestamp": datetime.datetime.now().isoformat(),
                "source_url": base_url,
                "location": location,
                "property_type": "Rental Properties",
                "price_filter": "Excludes properties over 1,000,000 TL",
                "room_filter": f"Filtered to {room_filter} rooms" if room_filter else "No room filter applied",
                "pages_scraped": len(set([p.get('page', 1) for p in properties]))
             },
            "statistics": stats,
            "properties_by_price_range": properties_by_range,
            # "properties_per_page": page_counts,
            # "properties": properties
        }

        return json_data


    def parse_real_estate_results(self,url, max_pages=5, room_filter=None):
        """
        Main scraping function

        Args:
            url (str): Emlakjet URL to scrape
            max_pages (int): Number of pages to scrape (default: 5)
            room_filter (str): Room size filter (e.g., "3+1", "2+1", "4+1", "1+1") (default: None)

        Returns:
            dict: JSON data with scraped properties
        """
        if not url:
            print("❌ No URL provided!")
            return None

        if "emlakjet.com" not in url:
            print("❌ Please provide a valid Emlakjet URL!")
            return None

        print(f"🚀 Starting to scrape: {url}")
        print(f"📄 Pages to scrape: {max_pages}")
        if room_filter:
            print(f"🏠 Room filter: {room_filter}")
        print("🔄 Processing...\n")

        # Use Selenium for comprehensive scraping of all pages
        properties = self.scrape_with_selenium(url, max_pages=max_pages)

        if properties:
            print(f"✅ Found {len(properties)} properties total")

            # Clean and prepare data for JSON (filters out >1M TL and applies room filter)
            cleaned_properties = self.clean_and_analyze_prices(properties, room_filter=room_filter)

            if cleaned_properties:
                # Generate JSON output
                json_data = self.generate_json_output(cleaned_properties, url, room_filter=room_filter)

                # Print the complete JSON to console
                print("\n" + "=" * 80)
                print("📋 JSON OUTPUT:")
                print("=" * 80)
                print(json.dumps(json_data, ensure_ascii=False, indent=2))
                print("=" * 80)

                return json_data
            else:
                print("❌ Could not parse any valid property data")
                if room_filter:
                    print(f"   • No properties found matching room filter: {room_filter}")
                    print("   • Try a different room size or remove the filter")
        else:
            print("❌ No properties found. Possible issues:")
            print("   • Site structure may have changed")
            print("   • Anti-scraping measures detected")
            print("   • URL may not have properties")
            print("   • Try a different URL or check internet connection")


# if __name__ == "__main__":
#     # Example usage:
#
#     # Basic usage - scrape all room types
#     # main("https://www.emlakjet.com/kiralik-konut/ankara", 5)
#
#     # With room filter - only 3+1 apartments
#     # main("https://www.emlakjet.com/kiralik-konut/ankara", 5, room_filter="3+1")
#
#     # With room filter - only 2+1 apartments
#     # main("https://www.emlakjet.com/kiralik-konut/yozgat", 3, room_filter="2+1")
#
#     print("Script ready to use. Call main(url, max_pages, room_filter) function.")
#     # print("Example: main('https://www.emlakjet.com/kiralik-konut/ankara', 5, '3+1')")

# if __name__ == "__main__":
#     # Required packages (install with pip):
#     # pip install requests beautifulsoup4 selenium pandas lxml
#     # Also need to install ChromeDriver for Selenium
#     real_estate_prices=RealEstate()
#     google_search=Search()
#     search_results=google_search.search("site:emlakjet.com ankara ümitköy kiralık daire")
#     print(search_results)
#     parsed_links=google_search.parse_search_links(search_results)
#
#     real_estate_prices.parse_real_estate_results(parsed_links[0], 4,"2+1")