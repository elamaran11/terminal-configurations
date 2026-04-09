#!/bin/bash
CACHE=~/.cache/weather_location
CACHE_AGE=3600

mkdir -p ~/.cache
if [ -f "$CACHE" ] && [ $(($(date +%s) - $(stat -f%m "$CACHE"))) -lt $CACHE_AGE ]; then
    cat "$CACHE"
    cp "$CACHE" /tmp/location_cache.txt 2>/dev/null
    exit 0
fi

DATA=$(curl -sf --max-time 3 "http://ip-api.com/json/?fields=city,lat,lon" 2>/dev/null)
CITY=$(echo "$DATA" | sed -n 's/.*"city":"\([^"]*\)".*/\1/p')
# Also cache lat/lon for weather script
LAT=$(echo "$DATA" | sed -n 's/.*"lat":\([0-9.]*\).*/\1/p')
LON=$(echo "$DATA" | sed -n 's/.*"lon":\(-*[0-9.]*\).*/\1/p')
if [ -n "$CITY" ]; then
    echo "$CITY" > "$CACHE"
    [ -n "$LAT" ] && echo "${LAT},${LON}" > ~/.cache/weather_coords
else
    [ -f "$CACHE" ] && grep -qv "N/A" "$CACHE" && cat "$CACHE" && exit 0
    echo "N/A" > "$CACHE"
fi
cp "$CACHE" /tmp/location_cache.txt 2>/dev/null
cat "$CACHE"
