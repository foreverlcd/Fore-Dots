#!/bin/bash

if command -v asusctl >/dev/null 2>&1; then
    # Guardamos todo el output
    output=$(asusctl profile get)

    # Buscamos la coincidencia exacta de la línea "Active profile"
    if [[ "$output" == *"Active profile: Quiet"* ]]; then
        echo "󰾆 Quiet"
    elif [[ "$output" == *"Active profile: Performance"* ]]; then
        echo "󰓅 Performance"
    else
        echo "󰾅 Balanced"
    fi
fi
