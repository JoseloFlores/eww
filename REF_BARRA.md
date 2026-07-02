# Guía de Referencia: Barra Eww (Recreación de Eww)

## Comandos Útiles
- **Reiniciar la barra:** `~/.config/hypr/eww_restart.sh`
- **Ver logs de error:** `~/.cargo/bin/eww logs`
- **Abrir inspector (CSS):** `~/.cargo/bin/eww inspector`

## Estructura de la Configuración
- `eww.yuck`: Contiene la lógica y estructura.
  - `bar`: La ventana principal.
  - `workspaces_json`: Listener para Hyprland.
  - `quicksettings`: Grupo de red, audio, brillo y batería.
- `eww.scss`: Estilos visuales.
  - Modifica `$module-bg` para cambiar la transparencia de los módulos.
  - Modifica las variables `$accentX` para cambiar los colores de los iconos.
- `scripts/`:
  - `workspaces.sh`: Gestiona los iconos de espacios de trabajo (󰮯 activo,  ocupado,  vacío).
  - `audio.sh`: Cambia iconos según el volumen y estado de silencio.
  - `music.sh`: Muestra el artista y canción actual (vía playerctl).

## Personalización
Si deseas cambiar los iconos de los workspaces, edita `eww.yuck` en la sección `(defwidget workspaces ...)`:
- Activo: `󰮯`
- Ocupado: ``
- Vacío: ``

## Notas Técnicas
- **Red:** Reutiliza el script original `~/.config/hypr/eww_network.sh`.
- **Batería:** Lee directamente de `/sys/class/power_supply/BAT0/`.
- **Temperatura:** Lee de `/sys/class/thermal/thermal_zone0/`.
