#!/bin/bash

# 1. Cambiar el volumen
if [ "$1" == "up" ]; then
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
else
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
fi

# 2. Obtener el nuevo valor formateado
NEW_INFO=$(/home/jose/.config/eww/scripts/audio.sh)

# 3. Forzar actualización inmediata en Eww
# Usamos el path absoluto para evitar problemas de entorno
/home/jose/.cargo/bin/eww update audio_info="$NEW_INFO"
