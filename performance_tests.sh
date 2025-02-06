#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Running Performance Tests...${NC}\n"

# Test recent financial data (last 5 years)
echo -e "${GREEN}1. Recent Financial Data Performance${NC}"
for year in {2023..2019}
do
    echo -e "\nTesting Year: $year"
    time curl -s "http://localhost/api/financial/income-statement/AAPL?period=annual" | grep "\"calendarYear\":\"$year\""
done

# Test cache performance for different endpoints
echo -e "\n${GREEN}2. Cache Performance Tests${NC}"
for i in {1..3}
do
    echo -e "\nRequest $i for Market Data:"
    time curl -s "http://localhost/api/market/quote/AAPL" > /dev/null
done

# Test concurrent requests
echo -e "\n${GREEN}3. Concurrent Request Test${NC}"
echo "Sending 5 concurrent requests..."
for i in {1..5}
do
    curl -s "http://localhost/api/company/profile/AAPL" > /dev/null &
done
wait

echo -e "\n${BLUE}Performance Testing Complete!${NC}" 