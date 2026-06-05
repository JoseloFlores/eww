#!/bin/bash

# Generar icono de brillo
brightness=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

if [ "$brightness" -lt 25 ]; then
    echo "󰃞 $brightness%"
elif [ "$brightness" -lt 50 ]; then
    echo "󰃝 $brightness%"
elif [ "$brightness" -lt 75 ]; then
    echo "󰃟 $brightness%"
else
    echo "󰃠 $brightness%"
fi
