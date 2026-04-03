#!/bin/bash
CACHE=~/.cache/weather_location
CACHE_AGE=3600

mkdir -p ~/.cache
if [ -f "$CACHE" ] && [ $(($(date +%s) - $(stat -f%m "$CACHE"))) -lt $CACHE_AGE ]; then
    cat "$CACHE"
    exit 0
fi

CITY=$(curl -sf --max-time 3 "ipinfo.io/city" 2>/dev/null)
if [ -n "$CITY" ]; then
    echo "$CITY" > "$CACHE"
else
    echo "N/A" > "$CACHE"
fi
cat "$CACHE"
