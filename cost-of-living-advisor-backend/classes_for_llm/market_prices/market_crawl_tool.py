import asyncio
from crawl4ai import AsyncWebCrawler

async def fetchSiteHTML(name):
    async with AsyncWebCrawler() as crawler:
        result = await crawler.arun(name)
        return result.html

