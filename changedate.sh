#!/bin/bash

clear
echo -e "\033[01;36mLista de usuários e data de expiração do mesmo:"; echo ""
NUMBER=$(awk  -F : '$3 >= 500 {print  $1}'  /etc/passwd | grep -v "nobody" | sort | wc -l)
if [ $NUMBER = "0" ]; then
  echo -e "\033[01;33mVocê não possui nenhum usuário SSH criado no momento!"
  echo ""
  echo -e "\033[01;33mCrie um usuário SSH para prosseguir com esta função!"
  echo ""
  echo -e "\033[01;36mAPERTE A TECLA ENTER PARA VOLTAR AO MENU..."
  read ENTER
  h
  exit
else
  for USERS in `awk  -F : '$3 >= 500 {print  $1}'  /etc/passwd | grep -v "nobody" | sort`; do
    EXPIRE=$(chage -l $USERS | grep -E "Account expires" | cut -d " " -f3-)
    if [[ $EXPIRE = "never" ]]; then
      echo -ne "\033[01;33m$(printf '%-36s%s\n' " $USERS" "Nunca")"; echo -e "\033[01;32m      (ATIVO)"
    else
      DATEBR=$(date -d "$EXPIRE" '+%Y%m%d')
      TODAY=$(date -d today '+%Y%m%d')
    if [ $TODAY -ge $DATEBR ]; then
      DATE=$(date -d "$EXPIRE" '+%d/%m/%Y')
      echo -ne "\033[01;33m$(printf '%-36s%s\n' " $USERS" "$DATE")"; echo -e "\033[01;31m (EXPIRADO)"
    else
      DATE=$(date -d "$EXPIRE" '+%d/%m/%Y')
      echo -ne "\033[01;33m$(printf '%-36s%s\n' " $USERS" "$DATE")"; echo -e "\033[01;32m (ATIVO)"
    fi
    fi
  done
fi
echo ""
echo -e "\033[01;32m0: RETORNAR AO MENU."
echo -e "\033[01;32mR: RESETAR."
echo ""
echo -ne "\033[01;36mNome do usuário para alterar a data de validade:\033[01;37m "; read USER
if [ -z $USER ]; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou um nome de usuário vazio. Tente novamente!\033[0m"
  sleep 3s
  changedate
  exit
else
  awk  -F : '$3 >= 500 {print  $1}'  /etc/passwd | grep -v "nobody" | sort > /tmp/users.txt
if [[ `grep -cx "$USER" /tmp/users.txt` -ne 1 ]]; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou um nome de usuário inexistente. Digite um nome de\033[0m"; echo -e "\033[01;37;41musuário que seja existente na lista acima. Tente novamente!   \033[0m"
  sleep 7s
  changedate
  exit
else
  echo -ne "\033[01;36mNova data de expiração (ANO/MÊS/DIA) para o usuário:\033[01;37m "; read NEWDATE
if [ -z $NEWDATE ]; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou uma data vazia. Tente novamente!\033[0m"
  sleep 3s
  changedate
  exit
else
if echo "$NEWDATE" | grep -q '[^0-9/R]'; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou uma data inválida. Tente novamente!\033[0m"
  sleep 3s
  changedate
  exit
else
  TODAY=$(date -d today '+%Y%m%d')
  TEMP=$(date -d "$NEWDATE" '+%Y%m%d')
if [[ $TODAY -ge $TEMP ]]; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou uma data inválida. Digite uma data futura no form\033[0m"; echo -e "\033[01;37;41mato: ANO/MÊS/DIA, por exemplo: 2019/01/01. Tente novamente!   \033[0m"
  sleep 7s
  changedate
  exit
else
  chage -E $NEWDATE $USER
  VALIDITY=$(date -d "$NEWDATE" "+%d/%m/%Y")
  clear
  echo -e "\033[01;36mLista de usuários e data de expiração do mesmo:"; echo ""
  for USERS in `awk  -F : '$3 >= 500 {print  $1}'  /etc/passwd | grep -v "nobody" | sort`; do
    EXPIRE=$(chage -l $USERS | grep -E "Account expires" | cut -d " " -f3-)
    if [[ $EXPIRE = "never" ]]; then
      echo -ne "\033[01;33m$(printf '%-36s%s\n' " $USERS" "Nunca")"; echo -e "\033[01;32m      (ATIVO)"
    else
      DATEBR=$(date -d "$EXPIRE" '+%Y%m%d')
      TODAY=$(date -d today '+%Y%m%d')
    if [ $TODAY -ge $DATEBR ]; then
      DATE=$(date -d "$EXPIRE" '+%d/%m/%Y')
      echo -ne "\033[01;33m$(printf '%-36s%s\n' " $USERS" "$DATE")"; echo -e "\033[01;31m (EXPIRADO)"
    else
      DATE=$(date -d "$EXPIRE" '+%d/%m/%Y')
      echo -ne "\033[01;33m$(printf '%-36s%s\n' " $USERS" "$DATE")"; echo -e "\033[01;32m (ATIVO)"
    fi
    fi
  done
  echo ""
  echo -e "\033[01;32mData de expiração do usuário alterada com sucesso!"
  echo ""
  echo -e "\033[01;32mVerifique as informações abaixo:"
  echo ""
  echo -e "\033[01;32mNome do usuário: $USER"
  echo -e "\033[01;32mData de expiração do usuário alterada para: $VALIDITY"
fi
fi
fi
fi
fi
echo ""
echo -ne "\033[01;36mAPERTE A TECLA ENTER..."
read ENTER
changedate
exit