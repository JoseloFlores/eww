#!/bin/bash
# Detectar la interfaz activa (la ruta por defecto)
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -n1)

if [ -z "$INTERFACE" ]; then
    TYPE="Red"
    NAME="Desconectado"
else
    # Si nmcli está disponible, lo usamos para obtener información precisa
    if command -v nmcli >/dev/null 2>&1; then
        NET_TYPE=$(nmcli -t -f DEVICE,TYPE device | grep "^${INTERFACE}:" | cut -d: -f2)
        CONN=$(nmcli -t -f DEVICE,CONNECTION device | grep "^${INTERFACE}:" | cut -d: -f2)
        
        if [ "$NET_TYPE" = "wifi" ]; then
            TYPE="Wifi"
            NAME="$CONN"
        elif [ "$NET_TYPE" = "ethernet" ]; then
            TYPE="Ethernet"
            if [[ "$CONN" == *"Wired"* || "$CONN" == *"cable"* || -z "$CONN" ]]; then
                NAME="Conectado"
            else
                NAME="$CONN"
            fi
        else
            TYPE="Red"
            NAME="Conectado"
        fi
    else
        # Si nmcli no está, usamos sysfs e iwgetid como fallback
        if [ -d "/sys/class/net/$INTERFACE/wireless" ]; then
            TYPE="Wifi"
            if command -v iwgetid >/dev/null 2>&1; then
                NAME=$(iwgetid -r "$INTERFACE" || echo "Conectado")
            else
                NAME="Conectado"
            fi
        else
            TYPE="Ethernet"
            NAME="Conectado"
        fi
    fi
fi

# Limpiar comillas para evitar JSON inválido
NAME=$(echo "$NAME" | sed 's/"/\\"/g')
TYPE=$(echo "$TYPE" | sed 's/"/\\"/g')

echo "{\"type\": \"$TYPE\", \"name\": \"$NAME\"}"
