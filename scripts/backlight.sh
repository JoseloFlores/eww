#!/bin/bash

# Generar icono de brillo
brightness=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

if [ "$brightness" -lt 25 ]; then
    ICON="󰃞"
elif [ "$brightness" -lt 50 ]; then
    ICON="󰃝"
elif [ "$brightness" -lt 75 ]; then
    ICON="󰃟"
else
    ICON="󰃠"
fi

echo "{\"text\": \"$ICON\", \"tooltip\": \"Brillo: $brightness%\"}"
