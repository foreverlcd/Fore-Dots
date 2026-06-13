# Fore-Dots

Repositorio personal para la gestión de mis dotfiles y configuraciones del sistema en Arch Linux.

## Entorno

- **OS**: Arch Linux
- **WM**: Hyprland
- **Barra**: Waybar
- **Gestión de Temas**: nwg-look (Modo oscuro global activo)

## Hardware (ASUS)

- `system-asus/`: Contiene configuraciones específicas para el control de hardware ASUS
  (ventiladores, gestión de energía y switching de gráficos).

## Estructura

- `hypr/`: Configuración principal de Hyprland (reglas de blur, keybinds, autostart).
- `waybar/`: Estilos CSS y configuración de la barra de estado.
- `gtk-3.0/` & `gtk-4.0/`: Configuración del tema oscuro para aplicaciones GTK.

## Instalación

Para aplicar estas configuraciones en una instalación limpia:

1. Clona este repositorio: `git clone https://github.com/foreverlcd/Fore-Dots.git`
2. Crea los enlaces simbólicos hacia `~/.config/`:

```bash
   ln -s ~/Fore-Dots/hypr ~/.config/hypr
   ln -s ~/Fore-Dots/waybar ~/.config/waybar
   # etc...
```
