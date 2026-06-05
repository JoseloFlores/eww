#!/bin/bash

# Generar icono de audio basado en el volumen y estado de silencio
# Usamos LC_ALL=C para asegurar que el punto decimal se trate correctamente
raw_volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
volume=$(echo "$raw_volume * 100" | bc | cut -d. -f1)

# Si el volumen está vacío o no es número, poner 0
if [ -z "$volume" ]; then volume=0; fi

mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep "MUTED")

if [ -n "$mute" ]; then
    echo "󰝟 $volume%"
else
    if [ "$volume" -eq 0 ]; then
        echo "󰝟 $volume%"
    elif [ "$volume" -lt 33 ]; then
        echo "󰕿 $volume%"
    elif [ "$volume" -lt 66 ]; then
        echo "󰖀 $volume%"
    else
        echo "󰕾 $volume%"
    fi
fi
