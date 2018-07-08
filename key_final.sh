#!/bin/bash

###############EXEMPLO:#############
#Viva o Linux
#echo -e '\033[01;37mViva o \033[04;32mLinux\033[00;37m!!!'
#############################################
##CORES DE FONTES EM BOLD,###################
##INSERIR A COR NO INÍCIO E FINALIZA COM FIM
##EXEMPLO:
## echo -e $amar"SEU_TEXTO_AQUI"$fim
#############################################
pret="\033[1;30m"
verm="\033[1;31m"
verd="\033[1;32m"
amar="\033[1;33m"
azul="\033[1;34m"
mag="\033[1;35m"
cian="\033[1;36m"
bra="\033[1;37m"
fim="\033[0;37m"
#############################################


clear
#VERIFICAR EXECUÇAO COM BASH
if readlink /proc/$$/exe | grep -qs "dash"; then
	echo "NAO EXECUTE COM SH , E SIM COM BASH"
	exit 1
fi
#VERIFICAR ROOT
if [[ "$EUID" -ne 0 ]]; then
clear
	echo -e "DESCULPE, VOCE PRECISA\nSER UM USUARIO ROOT\nPARA RODAR O SCRIPT\n"
	exit 0
fi
#VERIFICAR PASTA E ARQUIVO
if [ ! -d "/etc/KEY_SERVER" ]; then
  mkdir /etc/KEY_SERVER/ 2>/dev/null
fi
if [ -e "/etc/KEY_SERVER/KEY_FILE" ]; then
  rm /etc/KEY_SERVER/KEY_FILE 2>/dev/null
fi

#RECEBER KEY
echo -e $verd"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
read -s -p " INSIRA SUA CHAVE DE ATIVAÇÃO: " KEY
# PARAMETRO "-s" OCULTA A KEY
if [ -z $KEY ]; then
clear
echo -e $verd"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
echo -e $verm" A KEY NAO FOI INSERIDA!"$fim
echo -e $verd"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
read -n 1 -s -p "APERTE QUALQUER TECLA PARA CONTINUAR..."
bash /home/cabox/workspace/key_final.sh
exit 0
fi
KEY_DOWN=$(wget -O /etc/KEY_SERVER/KEY_FILE  https://raw.githubusercontent.com/Leonn34/scripts/master/_KEY_ 1>/dev/null 2>/dev/null)
echo "$KEY_DOWN"
KEY_VER=$( cat /etc/KEY_SERVER/KEY_FILE )
if [ "$KEY" == "$KEY_VER" ]; then
	clear
	echo -e $verd"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
  echo -e $amar" KEY ACEITA!"$fim
	sleep 2
	echo -e $amar" INICIANDO A INSTALAÇÃO..."$fim
	echo -e $verd"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
	sleep 3
  #AQUI VAI O CONTEUDO DO SISTEMA
	wget -c -P /bin https://raw.githubusercontent.com/Leonn34/scriptsousatips/master/setup.sh 1>/dev/null 2>/dev/null && chmod +x /bin/setup.sh && bash /bin/setup.sh
else
#MENSAGEM RECUSANDO KEY
clear
echo -e $verd"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
echo -e $amar" KEY INVÁLIDA, TENTE NOVAMENTE!"$fim
echo -e $verd"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="$fim
read -n 1 -s -p "APERTE QUALQUER TECLA PARA CONTINUAR..."
bash /home/cabox/workspace/key_final.sh
exit 0
fi
