#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Running Simple Data Validation Tests...${NC}\n"

# Test key financial metrics
echo -e "${GREEN}1. Testing Key Financial Metrics for AAPL${NC}"
echo "Income Statement Data:"
curl -s "http://localhost/api/financial/income-statement/AAPL?period=annual"

# Compare data across services
echo -e "\n\n${GREEN}2. Cross-Service Data Validation${NC}"
echo -e "\nCompany Profile Data:"
curl -s "http://localhost/api/company/profile/AAPL"
echo -e "\n\nMarket Quote Data:"
curl -s "http://localhost/api/market/quote/AAPL"

# Test data freshness with timestamp
echo -e "\n\n${GREEN}3. Testing Cache Performance${NC}"
echo -e "\nFirst Request:"
time curl -s "http://localhost/api/market/quote/AAPL"
echo -e "\n\nSecond Request (should be faster):"
time curl -s "http://localhost/api/market/quote/AAPL"

echo -e "\n${BLUE}Simple Data Validation Complete!${NC}" 