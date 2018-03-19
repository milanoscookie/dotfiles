URL=https://www.accuweather.com/en/us/avon-ct/06001/weather-forecast/332257
w=$(wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $2": "$16", "$12"°" }'| head -1)
echo "  Avon: ${w[-3,-1]}"


