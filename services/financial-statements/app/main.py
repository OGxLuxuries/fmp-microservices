from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .routes import statements

app = FastAPI(title="Financial Statements Service")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(statements.router, prefix="/api/financial", tags=["financial"])

@app.get("/health")
async def health_check():
    return {"status": "healthy"} 