#!/bin/bash
# Cache file to avoid hammering API
CACHE=~/.cache/weather_temp
CACHE_AGE=600

mkdir -p ~/.cache
if [ -f "$CACHE" ] && [ $(($(date +%s) - $(stat -f%m "$CACHE"))) -lt $CACHE_AGE ]; then
    cat "$CACHE"
    exit 0
fi

# Use open-meteo (free, no key, reliable)
COORDS=$(curl -sf --max-time 3 "ipinfo.io/loc" 2>/dev/null)
if [ -z "$COORDS" ]; then echo "N/A" > "$CACHE"; cat "$CACHE"; exit 0; fi
LAT=$(echo "$COORDS" | cut -d, -f1)
LON=$(echo "$COORDS" | cut -d, -f2)
TEMP=$(curl -sf --max-time 3 "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m&temperature_unit=fahrenheit" 2>/dev/null | sed -n 's/.*"temperature_2m":\([0-9.]*\).*/\1/p')
if [ -n "$TEMP" ]; then
    echo "${TEMP}°F" > "$CACHE"
else
    echo "N/A" > "$CACHE"
fi
cat "$CACHE"
