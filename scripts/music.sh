#!/bin/bash

# Generar info de música
status=$(playerctl status 2>/dev/null)

if [ "$status" == "Playing" ]; then
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    echo "󰎆 $artist - $title" | cut -c 1-45
elif [ "$status" == "Paused" ]; then
    echo "󰏤 Pausado"
else
    echo ""
fi
