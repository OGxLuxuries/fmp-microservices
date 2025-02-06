from fastapi import APIRouter, HTTPException
import httpx
from ..config import settings

router = APIRouter()

@router.get("/profile/{symbol}")
async def get_company_profile(symbol: str):
    async with httpx.AsyncClient() as client:
        response = await client.get(
            f"{settings.BASE_URL}/profile/{symbol}",
            params={"apikey": settings.FMP_API_KEY}
        )
        
        if response.status_code != 200:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch company profile"
            )
        
        data = response.json()
        # Return first item if it's a list to avoid duplicate data
        return data[0] if isinstance(data, list) else data

@router.get("/employees/{symbol}")
async def get_employee_count(symbol: str):
    # The endpoint in FMP API might have changed, let's use the profile endpoint instead
    async with httpx.AsyncClient() as client:
        response = await client.get(
            f"{settings.BASE_URL}/profile/{symbol}",
            params={"apikey": settings.FMP_API_KEY}
        )
        
        if response.status_code != 200:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch employee data"
            )
        
        data = response.json()
        if isinstance(data, list) and len(data) > 0:
            return {"symbol": symbol, "employees": data[0].get("fullTimeEmployees")}
        return {"symbol": symbol, "employees": None} 