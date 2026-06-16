#!/bin/bash
# Detectar la interfaz activa (la ruta por defecto)
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -n1)
if [ -z "$INTERFACE" ]; then
    SSID="Desconectado"
else
    # Si es inalámbrica, obtener SSID, si no, mostrar nombre de interfaz
    if iw dev | grep -q "$INTERFACE"; then
        SSID=$(iwgetid -r "$INTERFACE" || echo "Desconectado")
    else
        SSID="Ethernet ($INTERFACE)"
    fi
fi
echo "{\"ssid\": \"$SSID\"}"
