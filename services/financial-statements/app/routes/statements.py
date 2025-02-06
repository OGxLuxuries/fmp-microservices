from fastapi import APIRouter, HTTPException
import httpx
from ..config import settings

router = APIRouter()

@router.get("/income-statement/{symbol}")
async def get_income_statement(symbol: str, period: str = "annual"):
    async with httpx.AsyncClient() as client:
        response = await client.get(
            f"{settings.BASE_URL}/income-statement/{symbol}",
            params={
                "apikey": settings.FMP_API_KEY,
                "period": period
            }
        )
        
        if response.status_code != 200:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch income statement"
            )
        
        return response.json()

@router.get("/balance-sheet/{symbol}")
async def get_balance_sheet(symbol: str, period: str = "annual"):
    async with httpx.AsyncClient() as client:
        response = await client.get(
            f"{settings.BASE_URL}/balance-sheet-statement/{symbol}",
            params={
                "apikey": settings.FMP_API_KEY,
                "period": period
            }
        )
        
        if response.status_code != 200:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch balance sheet"
            )
        
        return response.json() 