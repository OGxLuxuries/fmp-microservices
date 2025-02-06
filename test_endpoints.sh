#!/bin/bash

# Color codes for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting API Tests...${NC}\n"

# Market Data Service
echo -e "${GREEN}Testing Market Data Service...${NC}"
echo "1. Stock Quote for AAPL:"
curl -s "http://localhost/api/market/quote/AAPL" | json_pp
echo -e "\n\n2. Historical Price for AAPL:"
curl -s "http://localhost/api/market/historical-price/AAPL" | json_pp

# Company Info Service
echo -e "\n\n${GREEN}Testing Company Info Service...${NC}"
echo "1. Company Profile for AAPL:"
curl -s "http://localhost/api/company/profile/AAPL" | json_pp
echo -e "\n\n2. Employee Count for AAPL:"
curl -s "http://localhost/api/company/employees/AAPL" | json_pp

# Financial Statements Service
echo -e "\n\n${GREEN}Testing Financial Statements Service...${NC}"
echo "1. Income Statement for AAPL:"
curl -s "http://localhost/api/financial/income-statement/AAPL" | json_pp
echo -e "\n\n2. Balance Sheet for AAPL:"
curl -s "http://localhost/api/financial/balance-sheet/AAPL" | json_pp

# Health Checks
echo -e "\n\n${GREEN}Testing Health Endpoints...${NC}"
echo "1. Market Data Health:"
curl -s "http://localhost/api/market/health" | json_pp
echo -e "\n2. Company Info Health:"
curl -s "http://localhost/api/company/health" | json_pp
echo -e "\n3. Financial Statements Health:"
curl -s "http://localhost/api/financial/health" | json_pp

echo -e "\n${BLUE}Testing Complete!${NC}" 