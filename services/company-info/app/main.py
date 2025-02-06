from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .routes import company

app = FastAPI(title="Company Info Service")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(company.router, prefix="/api/company", tags=["company"])

@app.get("/health")
async def health_check():
    return {"status": "healthy"} 