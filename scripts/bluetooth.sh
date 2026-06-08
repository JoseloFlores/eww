#!/bin/bash

# Generar icono de bluetooth
if bluetoothctl show | grep -q "Powered: yes"; then
    # Check connected devices
    connected=$(bluetoothctl devices Connected | cut -d ' ' -f 3-)
    if [ -n "$connected" ]; then
        ICON="󰂱"
        TOOLTIP="Conectado: $connected"
    else
        ICON="󰂯"
        TOOLTIP="Encendido (Desconectado)"
    fi
else
    ICON="󰂲"
    TOOLTIP="Apagado"
fi

echo "{\"text\": \"$ICON\", \"tooltip\": \"$TOOLTIP\"}"
