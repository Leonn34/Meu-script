#!/bin/bash
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
read -p "INSIRA SUA KEY: " KEY 
if [ -z $KEY ]; then
clear
echo -e "A KEY NAO FOI INSERIDA"
exit 0
fi
KEY_DOWN=$(wget -O /etc/KEY_SERVER/KEY_FILE  https://raw.githubusercontent.com/Leonn34/scripts/master/KEY_FILE 1>/dev/null 2>/dev/null)
echo "$KEY_DOWN"
KEY_VER=$( cat /etc/KEY_SERVER/KEY_FILE )
if [ "$KEY" == "$KEY_VER" ]; then
  echo "OK"
  #AQUI VAI O CONTEUDO DO SISTEMA
else
#MENSAGEM RECUSANDO KEY
echo "SUA KEY NAO FOI ACEITA PELO SISTEMA"
exit 0
fi
