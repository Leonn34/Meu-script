#!/bin/bash
clear
echo "MENU STUNNEL4"
echo ""
echo "[1] ATIVAR"
echo "[2] DESATIVAR"
echo "[3] SAIR"
echo ""
read -p " [1-3] " opcao
echo " OPÇÃO ESCOLHIDA: " $opcao
case $opcao in
	1)
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
	wget https://raw.githubusercontent.com/Leonn34/scripts/master/stunnel.sh && chmod +x stunnel.sh && ./stunnel.sh
	fi
	;;
	2)
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
	menu2
	;;
	3)
	menu2
	*)
	echo "OPÇÃO INVÁLIDA!"
	sleep 3
	menu2
	exit
esac
