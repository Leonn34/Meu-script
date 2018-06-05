#!/bin/bash
# Estudando shell script.
# by Alan Victor - consultalinux.com / wavelinux.com

SHC="$(which shc)"
if [ ! -z $SHC ] ; then
	if [ $# = 0 ] ; then
		echo "Informe o nome do script para compilar."
		exit 1
	fi

	if [ ! -e $1 ] ; then
		echo "Nome do script nao existe."
		exit 1
	fi
	if [ -x $SHC ] ; then
		nome=$(echo $1 | sed 's/.sh$//')
		STDERR=$($SHC -f $1 2>&1)
		rm $1.x.c
		mv $1.x $nome.bin
		clear
		echo "Tentando gerar o binario..."
		sleep 4
		if [ -e $nome.bin ] ; then
			echo
			echo "Binario gerado com sucesso!"
		else
			echo
			echo "Problema ao gerar o binario!"
			echo
			echo "Listando possiveis erros"
			echo "-------------------------------------------------------"
			echo "$STDERR" | egrep -v 'Success'
			echo
		fi
	fi
else
	clear
	echo "Compilador SHC nao instalado."
	echo
	echo "Baixando as fontes..."
	apt-get update 
	apt-get install gcc -y
	wget -q http://www.datsi.fi.upm.es/~frosal/sources/shc-3.8.9.tgz

	if [ -e shc-3.8.9.tgz ] ; then
		tar -xf shc-3.8.9.tgz
		cd shc-3.8.9
		gcc -o shc shc-3.8.9.c
		cp shc /usr/bin/
	else
		echo "Problema ao instalar o SHC, tente manualmente!"
	fi
fi
