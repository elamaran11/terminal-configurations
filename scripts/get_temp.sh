#!/bin/bash
CACHE=~/.cache/weather_temp
CACHE_AGE=600

mkdir -p ~/.cache
if [ -f "$CACHE" ] && [ $(($(date +%s) - $(stat -f%m "$CACHE"))) -lt $CACHE_AGE ]; then
    cat "$CACHE"
    cp "$CACHE" /tmp/weather_cache.txt 2>/dev/null
    exit 0
fi

# Get coords from location cache or fetch fresh
if [ -f ~/.cache/weather_coords ]; then
    COORDS=$(cat ~/.cache/weather_coords)
else
    COORDS=$(curl -sf --max-time 3 "http://ip-api.com/json/?fields=lat,lon" 2>/dev/null | sed -n 's/.*"lat":\([0-9.]*\).*"lon":\(-*[0-9.]*\).*/\1,\2/p')
fi
LAT=$(echo "$COORDS" | cut -d, -f1)
LON=$(echo "$COORDS" | cut -d, -f2)
if [ -z "$LAT" ]; then
    [ -f "$CACHE" ] && grep -qv "N/A" "$CACHE" && cat "$CACHE" && exit 0
    echo "N/A" > "$CACHE"; cp "$CACHE" /tmp/weather_cache.txt; cat "$CACHE"; exit 0
fi

TEMP=$(curl -sf --max-time 3 "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m&temperature_unit=fahrenheit" 2>/dev/null | sed -n 's/.*"temperature_2m":\([0-9.]*\).*/\1/p')
if [ -n "$TEMP" ]; then
    echo "${TEMP}°F" > "$CACHE"
else
    [ -f "$CACHE" ] && grep -qv "N/A" "$CACHE" && cat "$CACHE" && exit 0
    echo "N/A" > "$CACHE"
fi
cp "$CACHE" /tmp/weather_cache.txt 2>/dev/null
cat "$CACHE"
