#!/bin/bash

read -p "Introduce el número de sesión a detener: " session_number

# Buscar el PID del proceso 'xinit' relacionado con la sesión seleccionada
xinit_pid=$(ps aux | grep -E "xinit /usr/bin/mate-session -- /usr/bin/X :$session_number" | grep -v grep | awk '{print $2}')

if [[ -n $xinit_pid ]]; then
    echo "El proceso 'xinit' con sesión :$session_number será detenido. PID: $xinit_pid"

    # Intentar detener el proceso
    kill $xinit_pid
    sleep 2  # Esperar un momento para verificar si se detuvo

    # Verificar si sigue en ejecución
    if ps -p $xinit_pid > /dev/null; then
        echo "El proceso no se detuvo con SIGTERM. Usando SIGKILL..."
        kill -9 $xinit_pid
    fi

    # Verificar si el proceso se cerró completamente
    if ps -p $xinit_pid > /dev/null; then
        echo "No se pudo detener el proceso 'xinit' con sesión :$session_number. Es posible que necesites permisos de root."
    else
        echo "Proceso 'xinit' detenido con éxito."
    fi
else
    echo "No se encontró ningún proceso 'xinit' con sesión :$session_number."
fi

