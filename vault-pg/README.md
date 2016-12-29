# Vault demo using PostgreSQL as a secret backend

## Start by cleaning containers
$ ./clean.sh

## Start Vault and dependencies containers
$ ./start-vault.sh
```
2c1ff48fe2c9324440f7cc4d22153b7b43d3f2485423f4194ee91140a1030b35
7de9922b1c2434013db91999c062040bc6de3755d2c28322085b57e48d2cc048
36b6d44b015a8ccbfc5409337be929a3e01fb859f12943df53b35ba76e1b33f1
7e974d21d725fa076b82a9d968f0e74e0a6f6dad31d99c579be3fa4dae09a949
```
## Unseal the node
$ ./unseal-vault.sh
```
Sealed: true
Key Shares: 5
Key Threshold: 3
Unseal Progress: 1
Sealed: true
Key Shares: 5
Key Threshold: 3
Unseal Progress: 2
Sealed: false
Key Shares: 5
Key Threshold: 3
Unseal Progress: 0
```
## Authenticate using the root token
$ ./authenticate.sh
```
Successfully authenticated! You are now logged in.
token: 7b5fd4d5-8dfe-363b-842c-320f57ffd10d
token_duration: 0
token_policies: [root]
```
## Enable and configure PostgreSQL secret backend
$ ./configure_pg_backend.sh
```
Successfully mounted 'postgresql' at 'postgresql'!


The following warnings were returned from the Vault server:
* Read access to this endpoint should be controlled via ACLs as it will return the connection string or URL as it is, including passwords, if any.
Success! Data written to: postgresql/config/lease
Success! Data written to: postgresql/roles/readonly
```
## Get some credentials
$ ./get_pg_creds.sh
```
Key            	Value
---            	-----
lease_id       	postgresql/creds/readonly/cdf88673-e71d-b574-65a5-f33493348d63
lease_duration 	10m0s
lease_renewable	true
password       	c60c47bc-4949-9c88-ffa6-10ab52969b28
username       	root-974edcf2-254a-c849-27ed-3c0dbac06e50
```
$ ./get_pg_creds.sh
```
Key            	Value
---            	-----
lease_id       	postgresql/creds/readonly/48dd1aca-c8fe-ad2b-6861-3752835b33bf
lease_duration 	10m0s
lease_renewable	true
password       	d83df1fa-bde5-3693-5000-1f5e06e2af03
username       	root-816ec669-47ab-dead-b4ee-5283ebec1ee8
```
## Revoke part of the created credentials
$ ./revoke_token.sh postgresql/creds/readonly/48dd1aca-c8fe-ad2b-6861-3752835b33bf
```
Success! Revoked the secret with ID 'postgresql/creds/readonly/48dd1aca-c8fe-ad2b-6861-3752835b33bf', if it existed.
```
## Connect using non revoked credentials
$ ./pg_connect.sh root-974edcf2-254a-c849-27ed-3c0dbac06e50
```
Password for user root-974edcf2-254a-c849-27ed-3c0dbac06e50:
psql (9.6.1)
Type "help" for help.

postgres=> \du
                                                   List of roles
                 Role name                 |                         Attributes                         | Member of
-------------------------------------------+------------------------------------------------------------+-----------
 postgres                                  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 root-974edcf2-254a-c849-27ed-3c0dbac06e50 | Password valid until 2016-12-29 17:08:52+00                | {}
 ```
