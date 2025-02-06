#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Running Data Validation Tests...${NC}\n"

# Test key financial metrics
echo -e "${GREEN}1. Testing Key Financial Metrics for AAPL${NC}"
echo "Revenue and Profit Check:"
curl -s "http://localhost/api/financial/income-statement/AAPL?period=annual" | \
jq '[.[] | select(.calendarYear=="2023") | {revenue, grossProfit, netIncome}]'

# Compare data across services
echo -e "\n${GREEN}2. Cross-Service Data Validation${NC}"
echo "Company Profile vs Financial Data:"
curl -s "http://localhost/api/company/profile/AAPL" > profile.json
curl -s "http://localhost/api/market/quote/AAPL" > quote.json
echo "Profile Data:"
cat profile.json | jq '.price, .mktCap'
echo "Quote Data:"
cat quote.json | jq '.[0] | .price, .marketCap'
rm profile.json quote.json

# Test data freshness
echo -e "\n${GREEN}3. Testing Data Freshness${NC}"
echo "Latest Quote Timestamp:"
curl -s "http://localhost/api/market/quote/AAPL" | jq '.[0].timestamp'

echo -e "\n${BLUE}Data Validation Complete!${NC}" 