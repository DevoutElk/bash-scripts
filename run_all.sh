#!/bin/bash
echo "Hoy es " `date`

echo -e "\nIngresa la ruta al directorio"
read the_path

echo -e "\n tu ruta tiene los siguientes archivos y carpetas"
ls $the_path
