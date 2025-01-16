#!/bin/sh

# netejar regles
echo "netejar regles..."
iptables -F INPUT
iptables -F FORWARD
iptables -F OUTPUT

# Flush chains
echo "Flush chains..."
iptables -X

# Fiquem a 0 el contador de paquets i bytes
echo "Fiquem a 0 el contador de paquets i bytes..."
iptables -Z

# Flush de la taula NAT
echo "Flush de la taula NAT..."
iptables -t nat -F

# Politica per defecte restictiva (DROP)
echo "Aplicant politica restrictiva (DROP)..."
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# Permetem operativitat a localhost per als serveis interns del sistema
echo "Permetem operativitat a localhost per als serveis interns del sistema..."
iptables -A INPUT -s 127.0.0.1 -i lo -j ACCEPT
iptables -A OUTPUT -d 127.0.0.1 -o lo -j ACCEPT

# Limitem el nombre de connexions tcp entrants
iptables -N syn_flood
iptables -A INPUT -p tcp --syn -j syn_flood
iptables -A syn_flood -m limit --limit 1/s --limit-burst 3 -j RETURN
iptables -A syn_flood -j DROP

# Limitem les peticions de ping
iptables -A INPUT -p icmp -m limit --limit 1/s --limit-burst 1 -j ACCEPT
iptables -A INPUT -p icmp -m limit --limit 1/s --limit-burst 1 -j LOG --log-prefix PING-DROP:
iptables -A INPUT -p icmp -j DROP
iptables -A OUTPUT -p icmp -j ACCEPT

echo ""
echo "Configuracio final iptables..."
echo ""
#iptables -L -v

