#!/bin/sh
# 
# rc.flush-iptables - Reinicia iptables a sus valores por defecto.
# 
# Copyright (C) 2001  Oskar Andreasson <bluefluxATkoffeinDOTnet>
#
# Este programa es software libre; puedes redistribuirlo y/o modificarlo
# bajo los términos expresados en la "GNU General Public License", tal como
# lo publica la Free Software Foundation; versión 2 de la Licencia.
#
# Este programa se distribuye con el deseo de que sea útil, pero
# SIN NINGUNA GARANTÍA; incluso sin garantía implícita de COMPRA-VENTA
# o ADECUACIÓN A PROPÓSITO PARTICULAR. Para más detalles, referirse a la
# GNU General Public License.
#
# Deberías haber recibido una copia de la GNU General Public License
# junto a este programa o desde el sitio web de dónde lo bajaste;
# si no es así, escribe a la Free Software Foundation, Inc., 59 Temple
# Place, Suite 330, Boston, MA  02111-1307   USA

#
# Configuraciones.
#
IPTABLES="/sbin/iptables"

#
# Reinicia las políticas por defecto en la tabla Filter.
#
$IPTABLES -P INPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT
$IPTABLES -P OUTPUT ACCEPT

#
# Reinicia las políticas por defecto en la tabla Nat.
#
$IPTABLES -t nat -P PREROUTING ACCEPT
$IPTABLES -t nat -P POSTROUTING ACCEPT
$IPTABLES -t nat -P OUTPUT ACCEPT

#
# Reinicia las políticas por defecto en la tabla Mangle.
#
$IPTABLES -t mangle -P PREROUTING ACCEPT
$IPTABLES -t mangle -P OUTPUT ACCEPT

#
# Elimina todas las reglas de las tablas Filter y Nat.
#
$IPTABLES -F
$IPTABLES -t nat -F
$IPTABLES -t mangle -F
#
# Borra todas las cadenas que no vienen por defecto con las
# tablas Filter y Nat.
#
$IPTABLES -X
$IPTABLES -t nat -X
$IPTABLES -t mangle -X

echo "Tallafocs parat..."
