docker create -v /config --name config busybox; docker cp vault.hcl config:/config/
docker run -d --name consul -p 8500:8500 consul:0.7.1 agent -dev -client=0.0.0.0
docker run --name postgres -e POSTGRES_PASSWORD=my_secret_password -d postgres:9.6
docker run -d --name vault-dev --link consul:consul --link postgres:postgres -p 8200:8200 --volumes-from config vault:0.6.4 server -config=/config/vault.hcl
