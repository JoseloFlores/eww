#!/bin/bash

# Generar icono de audio basado en el volumen y estado de silencio
raw_volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
volume=$(echo "$raw_volume * 100" | bc | cut -d. -f1)

# Si el volumen está vacío o no es número, poner 0
if [ -z "$volume" ]; then volume=0; fi

mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep "MUTED")

if [ -n "$mute" ]; then
    ICON="󰝟"
    TOOLTIP="Silenciado ($volume%)"
else
    if [ "$volume" -eq 0 ]; then
        ICON="󰝟"
    elif [ "$volume" -lt 33 ]; then
        ICON="󰕿"
    elif [ "$volume" -lt 66 ]; then
        ICON="󰖀"
    else
        ICON="󰕾"
    fi
    TOOLTIP="Volumen: $volume%"
fi

echo "{\"text\": \"$ICON $volume%\", \"tooltip\": \"$TOOLTIP\"}"
