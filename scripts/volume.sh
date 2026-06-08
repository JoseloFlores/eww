#!/bin/bash

# 1. Cambiar el volumen
if [ "$1" == "up" ]; then
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+
else
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
fi

# 2. Obtener el nuevo valor formateado
NEW_INFO=$(/home/jose/.config/eww/scripts/audio.sh)

# 3. Forzar actualización inmediata en Eww
/home/jose/eww/target/release/eww update audio_json="$NEW_INFO"
