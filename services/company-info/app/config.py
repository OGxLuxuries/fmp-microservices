import os
from dotenv import load_dotenv

load_dotenv()

class Settings:
    FMP_API_KEY: str = os.getenv("FMP_API_KEY")
    BASE_URL: str = "https://financialmodelingprep.com/api/v3"

settings = Settings() 