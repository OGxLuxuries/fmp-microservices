import os
from dotenv import load_dotenv

load_dotenv()

class Settings:
    FMP_API_KEY: str = os.getenv("FMP_API_KEY")
    BASE_URL: str = "https://financialmodelingprep.com/api/v3"
    REDIS_HOST: str = os.getenv("REDIS_HOST", "redis")
    REDIS_PORT: int = int(os.getenv("REDIS_PORT", 6379))

settings = Settings()