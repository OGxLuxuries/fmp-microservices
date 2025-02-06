#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Testing Redis Cache Performance...${NC}"
echo -e "${GREEN}First request (should be slower):${NC}"
time curl -s "http://localhost/api/market/quote/AAPL" | json_pp
echo -e "\n${GREEN}Second request (should be faster due to cache):${NC}"
time curl -s "http://localhost/api/market/quote/AAPL" | json_pp

echo -e "\n${BLUE}Testing Different Symbols...${NC}"
echo -e "${GREEN}Valid symbol (MSFT):${NC}"
curl -s "http://localhost/api/company/profile/MSFT" | json_pp
echo -e "\n${GREEN}Invalid symbol:${NC}"
curl -s "http://localhost/api/company/profile/INVALID" | json_pp

echo -e "\n${BLUE}Testing Different Periods...${NC}"
echo -e "${GREEN}Annual statements:${NC}"
curl -s "http://localhost/api/financial/income-statement/AAPL?period=annual" | json_pp
echo -e "\n${GREEN}Quarterly statements:${NC}"
curl -s "http://localhost/api/financial/income-statement/AAPL?period=quarter" | json_pp

echo -e "\n${BLUE}Testing Complete!${NC}" 