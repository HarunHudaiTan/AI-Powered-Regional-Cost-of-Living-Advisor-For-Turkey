import asyncio
from crawl4ai import AsyncWebCrawler, CrawlerRunConfig, DefaultMarkdownGenerator
import re
import json

class FuelPrices():

    async def fetch_fuel_prices(self,city):
        """Fetches fuel prices for a certain Turkish city as markdown.

        Args:
            city: Name of the Turkish city. Must be in lowercase using only English alphabet characters. For example, 'ankara', 'istanbul', 'izmir', "karabuk", "agri". Convert Turkish characters (e.g., 'ğ', 'ş', 'ç', 'ü', 'ı', 'ö') to their English equivalents ('g', 's', 'c', 'u', 'i', 'o').

        Returns:
            Markdown of fuel prices of the chosen Turkish city.
        """

        md_generator = DefaultMarkdownGenerator(
            options={"ignore_images": True}
        )

        config = CrawlerRunConfig(
            target_elements=[
                'h1.page-title', # Descriptive title
                'div.table.sortable',  # Fuel prices table
                'div.article-content.kur-page > span'  # Summary text
            ],
            markdown_generator=md_generator
        )

        async with AsyncWebCrawler() as crawler:

            if city.replace("İ", "i").casefold() == "istanbul":
                ist_europe = await crawler.arun("https://www.doviz.com/akaryakit-fiyatlari/istanbul-avrupa", config=config)
                ist_asia = await crawler.arun("https://www.doviz.com/akaryakit-fiyatlari/istanbul-anadolu", config=config)
                return self.parse_markdown_to_json(ist_europe.markdown + ist_asia.markdown)
            else:
                url = f"https://www.doviz.com/akaryakit-fiyatlari/{city}"
                result = await crawler.arun(url, config=config)
                return self.parse_markdown_to_json(result.markdown)


    def parse_markdown_to_json(self,markdown_text):
        sections = re.split(r'#\s+', markdown_text)[1:]  # split by region headers
        output = {
            "location": "",
            "date": "",
            "regions": []
        }

        for section in sections:
            lines = section.strip().split('\n')

            # Extract region name
            title_line = lines[0].strip()
            region_full = title_line.replace("Akaryakıt Fiyatları", "").strip()
            parts = region_full.split()
            if len(parts) == 1:
                location = parts[0]
                region_name = parts[0]
            else:
                location = parts[0]
                region_name = ' '.join(parts[1:])
            output["location"] = location

            # Extract table lines
            table_start = 0
            for i, line in enumerate(lines):
                if "|" in line and "---" in line:
                    table_start = i + 1
                    break

            table_lines = []
            for line in lines[table_start:]:
                if '|' not in line:
                    break
                table_lines.append(line.strip())

            prices = []
            last_date = ""

            for row in table_lines:
                cols = [col.strip().replace('₺', '').replace(',', '.').replace('-', 'null') for col in row.split('|')]
                distributor, gasoline, diesel, lpg, date = cols
                last_date = date
                prices.append({
                    "distributor": distributor,
                    "gasoline": f"{gasoline} TL" if gasoline != "null" else None,
                    "diesel": f"{diesel} TL" if diesel != "null" else None,
                    "lpg": f"{lpg} TL" if lpg != "null" else None,
                    "date": date
                })

            output["date"] = last_date

            # Extract average prices
            avg_line = ""
            for line in lines[::-1]:  # reverse search
                if "ortalama benzin fiyatı" in line:
                    avg_line = line
                    break

            avg_match = re.search(
                r"benzin fiyatı ([\d,]+) lira.*?motorin fiyatı ([\d,]+) lira.*?LPG fiyatı ([\d,]+) lira",
                avg_line
            )

            if avg_match:
                gasoline_avg = avg_match.group(1).replace(',', '.') + " TL"
                diesel_avg = avg_match.group(2).replace(',', '.') + " TL"
                lpg_avg = avg_match.group(3).replace(',', '.') + " TL"
            else:
                gasoline_avg = diesel_avg = lpg_avg = None

            output["regions"].append({
                "region_name": region_name,
                "prices": prices,
                "averages": {
                    "gasoline": gasoline_avg,
                    "diesel": diesel_avg,
                    "lpg": lpg_avg
                }
            })

        return json.dumps(output, indent=2, ensure_ascii=False)



# xyz = asyncio.run(fuel_prices.fetch_fuel_prices("canakkale"))
#
# print(xyz)