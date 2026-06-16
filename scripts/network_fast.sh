#!/bin/bash
INTERFACE="wlan0"
R1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
T1=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)
sleep 0.2
R2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
T2=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)
RX=$(( (R2 - R1) * 5 / 1024 )) # *5 porque dormimos 0.2s
TX=$(( (T2 - T1) * 5 / 1024 ))

format_speed() {
    if [ $1 -gt 1024 ]; then
        echo "$(echo "scale=1; $1/1024" | bc) M"
    else
        echo "$1 K"
    fi
}

echo "{\"down\": \"$(format_speed $RX)\", \"up\": \"$(format_speed $TX)\", \"down_raw\": $RX, \"up_raw\": $TX}"
