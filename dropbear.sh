#!/bin/bash
####################################
#CORES:
#ESTILOS:
#00: Nenhum
#01: Negrito
#04: Sublinhado
#05: Piscante
#07: Reverso
#08: Oculto
####################################
#CORES TEXTO:
#30: preto
#31: Vermelho
#32: verde
#33: amarelo
#34: Azul
#35: Magenta (Rosa)
#36: Ciano (Azul Ciano)
#37: branco
####################################
#CORES FUNDO:
#40: pretoo
#41: Vermelho
#42: verde
#43: Amarelo
#44: Azul
#45: Magenta (Rosa)
#46: Ciano (Azul Ciano)
#47: Branco
###############EXEMPLO:#############
#Viva o Linux
#echo -e '\033[01;37mViva o \033[04;32mLinux\033[00;37m!!!'
#############################################
##CORES DE FONTES,###################
##INSERIR A COR NO INÍCIO E FINALIZA COM FIM
##EXEMPLO:
## echo -e $amarelo"SEU_TEXTO_AQUI"$fim
#############################################
corPadrao="\033[0m"
preto="\033[0;30m"
vermelho="\033[0;31m"
verde="\033[0;32m"
marrom="\033[0;33m"
azul="\033[0;34m"
purple="\033[0;35m"
cyan="\033[0;36m"
cinzaClaro="\033[0;37m"
pretoCinza="\033[1;30m"
vermelhoClaro="\033[1;31m"
verdeClaro="\033[1;32m"
amarelo="\033[1;33m"
azulClaro="\033[1;34m"
purpleClaro="\033[1;35m"
cyanClaro="\033[1;36m"
branco="\033[1;37m"
fim="\033[0;37m"
#############################################
clear
echo -e $verdeClaro"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
echo -e $branco" MENU DROPBEAR"$fim
echo ""
echo -e $amarelo" [1]"$fim $branco"ATIVAR"$fim
echo -e $amarelo" [2]"$fim $branco"DESATIVAR"$fim
echo -e $amarelo" [3]"$fim $branco"VOLTAR"$fim
echo -e $verdeClaro"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
read -p " DIGITE SUA OPÇÃO: [1-3] " opcao
echo -e $cinzaClaro" OPÇÃO ESCOLHIDA:"$fim $branco$opcao$fim

case $opcao in

1)
#verificando o bkp
clear
echo -e $verdeClaro"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
if [ -e "/etc/default/dropbear" ] ; then
	echo -e $amarelo" CONFIGURANDO DROPBEAR..."$fim
else
	echo -e $amarelo" INSTALANDO DROPBEAR"$fim
sleep 3
apt-get update && apt-get install dropbear -y
fi

if [ -e "/etc/default/dropbear.bkp" ] ; then
	echo -e $amarelo" AGUARDE..."$fim
else
	#echo "Criando Backup..."
sleep 3
	cp /etc/default/dropbear /etc/default/dropbear.bkp
fi
echo -e $amarelo" CONFIGURANDO DROPBEAR AGUARDE..."$fim
sleep 3
service dropbear stop
sleep 5
echo "#Dropbear" > /etc/default/dropbear
echo "NO_START=0" >> /etc/default/dropbear
echo "DROPBEAR_PORT=443" >> /etc/default/dropbear
echo 'DROPBEAR_EXTRA_ARGS="-p 80"' >> /etc/default/dropbear
# DESATIVANDO A PORTA 443 NO SSH
grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
echo "#Port 443" >> /etc/ssh/sshd_config
# REINICIANDO SERVIÇOS
service squid3 stop
service ssh restart
service dropbear start
service dropbear restart
sleep 5
echo -e $amarelo" REINICIANDO SERVIÇOS..."$fim
sleep 3
echo -e $amarelo" DROPBEAR CONFIGURADO COM SUCESSO!"$fim
sleep 5
echo ""
echo -e $verdeClaro"ENTER"$fim $branco"para voltar"$fim
read -p " "
sleep 1
menu
;;
2)
#desativando
clear
echo -e $verdeClaro"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
echo -e $amarelo" AGUARDE UM MOMENTO..."$fim
service dropbear stop
sleep 3
clear
echo -e $verdeClaro"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
echo -e $amarelo" DESATIVANDO DROPBEAR..."$fim
sleep 3
clear
mv /etc/default/dropbear.bkp /etc/default/dropbear
# ATIVANDO A PORTA 443 NO SSH
grep -v "^#Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
echo "Port 443" >> /etc/ssh/sshd_config
# REINICIANDO SERVIÇOS
service squid3 stop
service ssh restart
service dropbear stop
sleep 5
clear
echo -e $verdeClaro"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
echo -e $amarelo" REINICIANDO SERVIÇOS..."$fim
sleep 3
clear
echo -e $verdeClaro"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
echo -e $amarelo" DROPBEAR DESATIVADO!"$fim
sleep 5
echo ""
echo -e $verdeClaro"ENTER"$fim $branco"para voltar"$fim
read -p " "
sleep 1
menu2
;;
3)
menu2
;;
*)
echo -e $amarelo" OPÇÃO INVÁLIDA!"$fim
sleep 3
dropbear.sh
exit
esac
