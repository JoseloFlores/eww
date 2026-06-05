#!/bin/bash

get_active_workspace() {
    hyprctl activeworkspace -j | jq -r '.id'
}

get_occupied_workspaces() {
    hyprctl workspaces -j | jq -r '.[].id'
}

generate_json() {
    active=$(get_active_workspace)
    occupied=$(get_occupied_workspaces)
    
    echo "["
    first=true
    # Solo mostrar los espacios que están ocupados o el que está activo
    # Ordenados por ID
    all_visible=$(echo -e "${active}\n${occupied}" | sort -nu)
    
    for i in $all_visible; do
        if [ "$i" == "null" ] || [ -z "$i" ]; then continue; fi
        
        is_active="false"
        if [ "$i" -eq "$active" ]; then is_active="true"; fi
        
        status="persistent"
        if [ "$is_active" == "true" ]; then status="active"; fi
        
        if [ "$first" = false ]; then echo ","; fi
        echo "{\"id\": $i, \"active\": $is_active, \"status\": \"$status\"}"
        first=false
    done
    echo "]"
}

if command -v socat >/dev/null 2>&1; then
    generate_json | jq -c .
    socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r line; do
        if [[ $line == workspace* ]] || [[ $line == focusedmon* ]] || [[ $line == openwindow* ]] || [[ $line == closewindow* ]] || [[ $line == movewindow* ]]; then
            generate_json | jq -c .
        fi
    done
else
    generate_json | jq -c .
fi
