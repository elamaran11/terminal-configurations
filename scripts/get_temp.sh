#!/bin/bash
# Get temperature for current location automatically
temp=$(curl -s --connect-timeout 3 'wttr.in/?format=%t' 2>/dev/null)
if [ -n "$temp" ] && [ "$temp" != "" ]; then
    echo "$temp"
else
    echo "N/A"  # Fallback when location can't be determined
fi
