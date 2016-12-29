. vault.ini
if [ -z "$1" ]
then
  echo You need to provide a token to revoke
  exit 1
fi
TOKEN=$1
set -- 
vault revoke -address=${VAULT_ADDR} $TOKEN
