# Financial Market Data Microservices

A microservices-based application that provides financial market data using the Financial Modeling Prep (FMP) API. The application consists of three main services: market data, company information, and financial statements.

## Architecture

- **Market Data Service**: Real-time quotes and historical prices with Redis caching
- **Company Info Service**: Company profiles and employee information
- **Financial Statements Service**: Income statements and balance sheets
- **Gateway**: Traefik reverse proxy for routing
- **Cache**: Redis for market data caching

## Prerequisites

- Docker and Docker Compose
- Financial Modeling Prep API key (from https://financialmodelingprep.com/developer)
- curl (for testing)

## File Structure 
/fmp-microservices
├── .env
├── docker-compose.yml
├── README.md
├── services/
│ ├── market-data/
│ ├── company-info/
│ └── financial-statements/
└── gateway/
└── traefik.yml


## Setup

1. Clone the repository
2. Create a `.env` file in the root directory:
env
FMP_API_KEY=your_api_key_here
REDIS_HOST=redis
REDIS_PORT=6379

3. Build and start the services:
bash
docker-compose up --build


## Available Endpoints

### Market Data Service
- GET `/api/market/quote/{symbol}` - Get real-time stock quote
- GET `/api/market/historical-price/{symbol}` - Get historical prices
- GET `/api/market/health` - Health check

### Company Info Service
- GET `/api/company/profile/{symbol}` - Get company profile
- GET `/api/company/employees/{symbol}` - Get employee count
- GET `/api/company/health` - Health check

### Financial Statements Service
- GET `/api/financial/income-statement/{symbol}` - Get income statements
- GET `/api/financial/balance-sheet/{symbol}` - Get balance sheets
- GET `/api/financial/health` - Health check

## Testing

Several test scripts are provided to validate the services:

1. Basic endpoint testing:
bash
./test_endpoints.sh

2. Simple validation testing:

bash
./simple_validation.sh

3. Advanced testing with cache verification:
bash
./advanced_tests.sh

4. Performance testing:
bash
./performance_tests.sh


5. Data validation:
bash
./validate_tests.sh


## Monitoring

Access the Traefik dashboard at:

http://localhost:8080/dashboard/

## Service Documentation

Each service has its own Swagger documentation:
- Market Data: http://localhost/api/market/docs
- Company Info: http://localhost/api/company/docs
- Financial Statements: http://localhost/api/financial/docs

## Key Files

- Docker Compose: ```yaml:docker-compose.yml
startLine: 1
endLine: 51

Market Data Service: python:services/market-data/app/main.pystartLine: 1endLine: 28
Company Info Service: python:services/company-info/app/main.pystartLine: 1endLine: 19
Financial Statements Service: python:services/financial-statements/app/main.pystartLine: 1endLine: 19
Cache Configuration
The market data service uses Redis for caching with a 60-second expiry. Cache configuration can be found in: python:services/market-data/app/utils/cache.pystartLine: 1endLine: 15