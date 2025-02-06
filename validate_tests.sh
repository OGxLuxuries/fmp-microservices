#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Running Validation Tests...${NC}\n"

# Test recent data (more reliable)
echo -e "${GREEN}1. Testing Recent Financial Data (2023)${NC}"
echo "Income Statement (Annual):"
curl -s "http://localhost/api/financial/income-statement/AAPL?period=annual" | json_pp
echo -e "\nBalance Sheet (Annual):"
curl -s "http://localhost/api/financial/balance-sheet/AAPL?period=annual" | json_pp

# Test error handling
echo -e "\n${GREEN}2. Testing Error Handling${NC}"
echo "Invalid Symbol:"
curl -s "http://localhost/api/financial/income-statement/INVALID123" | json_pp
echo -e "\nInvalid Period:"
curl -s "http://localhost/api/financial/income-statement/AAPL?period=invalid" | json_pp

# Test data consistency
echo -e "\n${GREEN}3. Testing Market Data Cache${NC}"
echo "First Request (uncached):"
time curl -s "http://localhost/api/market/quote/AAPL" | json_pp
echo -e "\nSecond Request (should be cached):"
time curl -s "http://localhost/api/market/quote/AAPL" | json_pp

echo -e "\n${BLUE}Validation Testing Complete!${NC}" 