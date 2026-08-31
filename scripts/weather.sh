#!/bin/bash
# Script de clima simplificado para eww

# Detectar la ciudad basada en la IP pública, con fallback a Buenos Aires si falla
# -4 fuerza IPv4 (evita timeout por DNS IPv6 en algunas redes)
# --connect-timeout 5 evita bloqueos largos
CITY=$(curl -4 -s --max-time 10 --connect-timeout 5 ipinfo.io/city | tr -d '\r\n' | tr ' ' '+')

if [ -z "$CITY" ]; then
    CITY="Buenos+Aires"
fi

RAW=$(curl -4 -s --max-time 10 --connect-timeout 5 "wttr.in/$CITY?format=%l|%t|%C|%h")

# Fallback: reintentar por https si el primer intento vacío (a veces http falla)
if [ -z "$RAW" ]; then
    RAW=$(curl -4 -s --max-time 10 --connect-timeout 5 "https://wttr.in/$CITY?format=%l|%t|%C|%h")
fi

if [ -n "$RAW" ]; then
    LOC=$(echo "$RAW" | cut -d'|' -f1)
    TEMP=$(echo "$RAW" | cut -d'|' -f2 | sed 's/+//')
    COND=$(echo "$RAW" | cut -d'|' -f3 | sed 's/ *$//')
    HUMID=$(echo "$RAW" | cut -d'|' -f4)
    
    case "$COND" in
        "Clear"|"Sunny") ICON="󰖙" ;;
        "Partly cloudy"|"PartlyCloudy") ICON="󰖕" ;;
        "Cloudy"|"Overcast") ICON="󰖐" ;;
        "Rain"|"Drizzle"|"Light rain"|"Light Rain"|"Moderate rain") ICON="󰖗" ;;
        "Thunderstorm") ICON="󰖓" ;;
        "Mist"|"Fog") ICON="󰖑" ;;
        *) ICON="󰖐" ;;
    esac

    # Usar jq para escapar JSON correctamente (evita romper con comas/comillas en LOC)
    if command -v jq >/dev/null 2>&1; then
        jq -n --arg loc "$LOC" --arg temp "$TEMP" --arg cond "$COND" --arg humid "$HUMID" --arg icon "$ICON" \
            '{location:$loc, temp:$temp, condition:$cond, humid:$humid, icon:$icon}'
    else
        echo "{\"location\": \"$LOC\", \"temp\": \"$TEMP\", \"condition\": \"$COND\", \"humid\": \"$HUMID\", \"icon\": \"$ICON\"}"
    fi
else
    FALLBACK_LOC=$(echo "$CITY" | tr '+' ' ')
    if command -v jq >/dev/null 2>&1; then
        jq -n --arg loc "$FALLBACK_LOC" '{location:$loc, temp:"--", condition:"Error", humid:"--", icon:"󰖐"}'
    else
        echo "{\"location\": \"$FALLBACK_LOC\", \"temp\": \"--\", \"condition\": \"Error\", \"humid\": \"--\", \"icon\": \"󰖐\"}"
    fi
fi
