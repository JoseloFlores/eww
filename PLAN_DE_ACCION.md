# Plan de Recreación de Barra Eww en Eww

Este documento detalla los pasos para recrear la estética y funcionalidad de la Eww actual en Eww para Hyprland.

## 1. Estructura de Archivos
- `~/.config/eww/eww.yuck`: Definición de la ventana, variables (poll/listen) y estructura de widgets.
- `~/.config/eww/eww.scss`: Estilos CSS (SASS) basados en la configuración de Eww.
- `~/.config/eww/scripts/`: Scripts auxiliares para obtener información dinámica.

## 2. Mapeo de Módulos
| Módulo Eww | Implementación en Eww | Script / Comando |
|---------------|----------------------|------------------|
| Workspaces    | `(box)` + `(for)`    | `scripts/workspaces.sh` (basado en `socat` o `hyprctl`) |
| Clock         | `(label)`            | `date` via `defpoll` |
| Battery       | `(label)`            | `/sys/class/power_supply` o `acpi` |
| Network       | `(label)`            | Reutilizar `~/.config/hypr/eww_network.sh` |
| Audio         | `(label)` + `(eventbox)` | `wpctl` o `pactl` |
| Backlight     | `(label)`            | `brightnessctl` |
| Power Menu    | `(box)` con botones  | Comandos `confirm_power.sh` |
| Updates       | `(label)`            | `check_updates.sh` |

## 3. Estética
- **Colores:** Se utilizará el tema `tokyonight` extraído de la configuración de Eww.
- **Forma:** Módulos en contenedores con `border-radius: 12px` y fondo `alpha(#24283b, 0.8)`.
- **Fuentes:** Nerd Fonts para iconos (Font Awesome y MesloLGM).

## 4. Pasos de Ejecución
1. Configurar `eww.scss` con las variables de color de Tokyo Night.
2. Implementar el widget de Workspaces (el más complejo).
3. Implementar widgets estáticos y de sondeo (reloj, batería).
4. Integrar scripts existentes de red y actualizaciones.
5. Diseñar el menú de energía.
6. Ajustar márgenes y espaciados para igualar a Eww.

## 5. Exclusiones
- **Tray:** No se incluirá soporte nativo de System Tray en esta fase por incompatibilidad directa en Eww/Wayland simple.
