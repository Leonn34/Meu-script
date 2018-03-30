#!/bin/bash

clear
echo "================ ATIVANDO STUNNEL ================"
if [ -d /etc/stunnel ] ; then
true
echo "CONFIGURANDO O SSH"
sleep 4
grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
echo "#Port 443" >> /etc/ssh/sshd_config
echo "============== REINICIANDO SERVIÇOS =============="
sleep 4
service squid3 stop
service ssh restart
service stunnel4 stop
service stunnel4 start
echo "================ STUNNEL ATIVADO! ================"
sleep 5
else
wget https://raw.githubusercontent.com/Leonn34/scripts/master/stunnel.sh && chmod+x stunnel.sh && ./stunnel.sh
fi
exit