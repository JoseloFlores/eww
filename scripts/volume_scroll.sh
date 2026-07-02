#!/bin/bash
if [ "$1" == "up" ]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+
else
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
fi
