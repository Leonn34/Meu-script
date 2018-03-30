#!/bin/bash

clear
echo "================ DESATIVANDO STUNNEL ================"
sleep 4
# REATIVANDO A PORTA 443 NO SSH
grep -v "^#Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
echo "Port 443" >> /etc/ssh/sshd_config

# REINICIANDO SERVIÇOS
service ssh restart
service squid3 start
service stunnel4 stop
sleep 5
echo "========== STUNNEL DESATIVADO COM SUCESSO! =========="
sleep 5
clear
exit
