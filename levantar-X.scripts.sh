#!/bin/bash

pidof mate-session > ~/Escritorio/mate-session.pid

read -p "Introduce el número de sesión: " session_number

# Verifica si ya hay un proceso relacionado con el número de sesión
if pgrep -af "mate-session -- :$session_number" | grep -q "startx"; then
    echo "El proceso con sesión :$session_number ya está en ejecución. Abortando"
else
    echo "Iniciando sesión :$session_number..."
    startx /usr/bin/mate-session -- :$session_number
fi
