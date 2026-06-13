#!/bin/bash

if command -v asusctl >/dev/null 2>&1; then
    # Usamos 'get' que es el subcomando correcto en tu versión
    perfil=$(asusctl profile get)

    if [[ "$perfil" == *"Quiet"* ]]; then
        echo "󰾆 Quiet"
    elif [[ "$perfil" == *"Performance"* ]]; then
        echo "󰓅 Performance"
    else
        echo "󰾅 Balanced"
    fi
else
    echo "󰅚 No asusctl"
fi