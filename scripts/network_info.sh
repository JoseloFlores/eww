#!/bin/bash
INTERFACE="wlan0"
SSID=$(iwgetid -r || echo "Desconectado")
echo "{\"ssid\": \"$SSID\"}"
