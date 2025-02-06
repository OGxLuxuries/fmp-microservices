from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .routes import quotes

app = FastAPI(
    title="Market Data Service",
    description="Service providing real-time and historical market data from Financial Modeling Prep API",
    version="1.0.0",
    docs_url="/docs",
    openapi_url="/openapi.json"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(quotes.router, prefix="/api/market", tags=["market"])

@app.get("/health", tags=["health"])
async def health_check():
    """
    Check if the service is healthy
    """
    return {"status": "healthy"} 