from fastapi import APIRouter, HTTPException
from typing import List, Dict, Any
import httpx
from ..config import settings
from ..utils.cache import get_cached_data, set_cached_data

router = APIRouter()

@router.get("/quote/{symbol}", 
    response_model=List[Dict[str, Any]],
    summary="Get Real-Time Stock Quote",
    description="Retrieve real-time stock quote data for a given symbol. Data is cached for 60 seconds."
)
async def get_stock_quote(
    symbol: str = "AAPL"
):
    """
    Get real-time stock quote for a specific symbol
    
    Parameters:
    - **symbol**: Stock symbol (e.g., AAPL for Apple Inc.)
    
    Returns:
    - List of quote data including current price, volume, and market cap
    """
    # Check cache
    cached_data = get_cached_data(f"quote:{symbol}")
    if cached_data:
        return cached_data
    
    # Fetch from FMP
    async with httpx.AsyncClient() as client:
        response = await client.get(
            f"{settings.BASE_URL}/quote/{symbol}",
            params={"apikey": settings.FMP_API_KEY}
        )
        
        if response.status_code != 200:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch quote data"
            )
        
        data = response.json()
        set_cached_data(f"quote:{symbol}", data)
        return data

@router.get("/historical-price/{symbol}",
    response_model=Dict[str, Any],
    summary="Get Historical Price Data",
    description="Retrieve historical price data for a given symbol"
)
async def get_historical_price(
    symbol: str = "AAPL"
):
    """
    Get historical price data for a specific symbol
    
    Parameters:
    - **symbol**: Stock symbol (e.g., AAPL for Apple Inc.)
    
    Returns:
    - Historical price data including daily open, high, low, close prices and volume
    """
    async with httpx.AsyncClient() as client:
        response = await client.get(
            f"{settings.BASE_URL}/historical-price-full/{symbol}",
            params={"apikey": settings.FMP_API_KEY}
        )
        
        if response.status_code != 200:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch historical data"
            )
        
        return response.json() 