#!/bin/bash
# Script de clima simplificado para eww

# Detectar la ciudad basada en la IP pública, con fallback a Buenos Aires si falla
CITY=$(curl -s --max-time 3 ipinfo.io/city | tr ' ' '+')

if [ -z "$CITY" ]; then
    CITY="Buenos+Aires"
fi

RAW=$(curl -s --max-time 5 "wttr.in/$CITY?format=%l|%t|%C|%h")

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
    # Limpiamos los símbolos "+" para el JSON de fallback
    FALLBACK_LOC=$(echo "$CITY" | tr '+' ' ')
    echo "{\"location\": \"$FALLBACK_LOC\", \"temp\": \"--\", \"condition\": \"Error\", \"humid\": \"--\", \"icon\": \"󰖐\"}"
fi
