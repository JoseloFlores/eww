#!/bin/bash

# Generar icono de bluetooth
if bluetoothctl show | grep -q "Powered: yes"; then
    # Check connected devices
    connected=$(bluetoothctl devices Connected)
    if [ -n "$connected" ]; then
        echo "󰂱 Connected"
    else
        echo "󰂯"
    fi
else
    echo "󰂲"
fi
