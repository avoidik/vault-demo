. vault.ini
vault init -address=${VAULT_ADDR} > keys.txt
vault unseal -address=${VAULT_ADDR} $(grep "Key 1:" keys.txt | awk '{print $NF}')
vault unseal -address=${VAULT_ADDR} $(grep "Key 2:" keys.txt | awk '{print $NF}')
vault unseal -address=${VAULT_ADDR} $(grep "Key 3:" keys.txt | awk '{print $NF}')
