. vault.ini
vault mount -address=${VAULT_ADDR} postgresql
vault write -address=${VAULT_ADDR}  postgresql/config/connection connection_url="user=postgres password=my_secret_password host=postgres port=5432 dbname=postgres sslmode=disable"
vault write -address=${VAULT_ADDR} postgresql/config/lease lease=10m lease_max=2h
vault write -address=${VAULT_ADDR} postgresql/roles/readonly sql="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"
