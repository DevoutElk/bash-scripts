#!/bin/bash

# Variables (ajusta estos valores según tu configuración)
PASSWORD_FILE="/ruta/al/archivo_de_contraseña"   # Archivo que contiene la contraseña
CLIP_RECT="800x600+0+0"                         # Resolución de la ventana VNC
CERT_FILE="/ruta/al/certificado_ssl.pem"         # Archivo del certificado SSL
KEY_FILE="/ruta/a/la_clave_privada.key"          # Archivo de la clave privada SSL
HTTP_DIR="/home/user/novnc"                     # Directorio donde está noVNC

# Comando x11vnc
x11vnc \
    -rfbauth $PASSWORD_FILE \        # Requiere contraseña para acceder
    -viewonly \                      # Modo solo visualización
    -clip $CLIP_RECT \               # Tamaño de ventana y recorte de pantalla
    -tightfilexfer \                 # Habilitar transferencia de archivos
    -shared \                        # Permitir múltiples usuarios conectados a la vez
    -forever \                       # No desconectar al cerrar un viewer
    -ssl SAVE \                      # Habilitar HTTPS
    -sslcert $CERT_FILE \            # Archivo de certificado SSL
    -sslkey $KEY_FILE \              # Archivo de clave privada SSL
    -http \                          # Habilitar servidor HTTP para visor VNC basado en HTML5
    -httpdir $HTTP_DIR \             # Directorio con el visor HTML5 noVNC
    -rfbport 5900 \                  # Puerto VNC (5900 por defecto)
    -bg \                            # Ejecutar en segundo plano
    -noskip_dups \                   # Mayor eficiencia en pantallas sin cambios
    -noxdamage \                     # Evitar daños en la pantalla durante la captura
    -repeat \                        # Permitir reconexiones automáticas
    -nodpms \                        # Evitar que la pantalla entre en modo de ahorro de energía
    -framerate 60 \                  # Establecer la frecuencia de actualización en 60 fps
    -wait 10                         # Tiempo de espera de 10 ms entre chequeos de pantalla
