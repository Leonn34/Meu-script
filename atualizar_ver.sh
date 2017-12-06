#!/bin/bash
     
SCRIPT_NAME="$0"
ARGS="$@"
NEW_FILE="/tmp/blog.sh"
VERSION="1.0"
     
check_upgrade () {
     
# verificar se existe uma nova versão deste arquivo
# aqui, hipoteticamente, verificamos se existe um arquivo no disco.
# pode ser um apt / yum check ou o que quer que seja ...
[ -f "$NEW_FILE" ] && {
     
# instale uma nova versão desse arquivo ou pacote
# novamente, neste exemplo, isso é feito simplesmente copiando o novo arquivo
echo "Encontrou uma nova versão de mim, me atualizando ..."
cp "$NEW_FILE" "$SCRIPT_NAME"
rm -f "$NEW_FILE"
     
# note que, neste momento, este arquivo foi substituído no disco
# agora execute este próprio arquivo, em sua nova versão!
echo "executando a nova versão ..."
$SCRIPT_NAME $ARGS
     
# agora saia dessa antiga instância
exit 0
}
     
echo "Eu sou VERSÃO $VERSION, já é a versão mais recente"
}
     
main () {
# material do script principal
echo "Olá Mundo! Eu sou a versão $VERSION do script"
}
     
check_upgrade
main
