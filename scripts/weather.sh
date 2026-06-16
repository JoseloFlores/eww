#!/bin/bash
# Script de clima simplificado para eww
# Usamos Buenos Aires fijo, pero se puede cambiar a "" para auto-IP
CITY="Buenos+Aires"
RAW=$(curl -s "wttr.in/$CITY?format=%l|%t|%C|%h")

if [ -n "$RAW" ]; then
    LOC=$(echo "$RAW" | cut -d'|' -f1)
    TEMP=$(echo "$RAW" | cut -d'|' -f2 | sed 's/+//')
    COND=$(echo "$RAW" | cut -d'|' -f3 | sed 's/ *$//')
    HUMID=$(echo "$RAW" | cut -d'|' -f4)
    
    case "$COND" in
        "Clear"|"Sunny") ICON="󰖙" ;;
        "Partly cloudy") ICON="󰖕" ;;
        "Cloudy"|"Overcast") ICON="󰖐" ;;
        "Rain"|"Drizzle"|"Light rain") ICON="󰖗" ;;
        "Thunderstorm") ICON="󰖓" ;;
        *) ICON="󰖐" ;;
    esac

    echo "{\"location\": \"$LOC\", \"temp\": \"$TEMP\", \"condition\": \"$COND\", \"humid\": \"$HUMID\", \"icon\": \"$ICON\"}"
else
    echo "{\"location\": \"Buenos Aires\", \"temp\": \"--\", \"condition\": \"Error\", \"humid\": \"--\", \"icon\": \"󰖐\"}"
fi
