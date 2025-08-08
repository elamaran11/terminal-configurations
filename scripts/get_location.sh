#!/bin/bash
# Get current location automatically
location=$(curl -s --connect-timeout 3 'wttr.in/?format=%l' 2>/dev/null)
if [ -n "$location" ] && [ "$location" != "" ]; then
    # Extract city and state, remove country
    echo "$location" | sed 's/, United States//' | sed 's/, Florida/, FL/'
else
    echo "Wesley Chapel, FL"  # Fallback location
fi
