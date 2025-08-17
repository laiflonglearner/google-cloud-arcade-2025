curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install vault
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=hvs.mlI5bGdl9AzPx81K6q5icj9T
vault status
vault token create -help
vault token create -ttl=1h -use-limit=2 -policy=default
export USE_LIMIT_TOKEN=hvs.CAESIDwI3F7Uu_GUtuhLXhqUdCUDapEgptTbEznaNN8DAVO8Gh4KHGh2cy5sRjFNSTQydHNNUjFQSGMyVjYwRFNYZjc
VAULT_TOKEN=$USE_LIMIT_TOKEN vault token lookup
VAULT_TOKEN=$USE_LIMIT_TOKEN vault write cubbyhole/token value=1234567890
VAULT_TOKEN=$USE_LIMIT_TOKEN vault read cubbyhole/token
vault token create -policy="default" -period=24h
vault token lookup hvs.CAESICnQPpxvCpw9fiQ9OG1QB1riw1zNGbMD_A3dtFpg8zs6Gh4KHGh2cy5yeGdsdURJYnhaellaMXlxc0U5d1puQ1g
vault token create -ttl=45 -explicit-max-ttl=120
export TOKEN=hvs.kJ7BeBXaDAoxggLEi2wD1PWa
vault token renew $TOKEN
vault token renew -increment=60 $TOKEN
vault token create -ttl=60s
vault token lookup hvs.C6ePu48gYrrxtYIhqRHvgRXC
vault secrets list
vault token lookup hvs.C6ePu48gYrrxtYIhqRHvgRXC
vault token create -orphan
vault token lookup hvs.9mCyqIYKRFyBtRtkhNbAY055
vault write auth/token/roles/zabbix     allowed_policies="policy1, policy2, policy3"     orphan=true     period=8h
vault token create -role=zabbix
vault policy write test -<<EOF
path "auth/token/create" {
   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOF

vault token create -ttl=60 -policy=test -format=json     | jq -r ".auth.client_token" > parent_token.txt
cat parent_token.txt
VAULT_TOKEN=$(cat parent_token.txt)    vault token create -ttl=180 -policy=default -format=json     | jq -r ".auth.client_token" > child_token.txt
cat child_token.txt
VAULT_TOKEN=$(cat parent_token.txt)    vault token create -orphan -ttl=180 -policy=default -format=json     | jq -r ".auth.client_token" > orphan_token.txt
vault token revoke $(cat parent_token.txt)
vault token lookup $(cat parent_token.txt)
vault token lookup $(cat child_token.txt)
vault token lookup $(cat orphan_token.txt)
unset VAULT_TOKEN
vault auth enable approle
vault write auth/approle/role/jenkins policies="jenkins" period="24h"
vault read -format=json auth/approle/role/jenkins/role-id     | jq -r ".data.role_id" > role_id.txt
vault write -f -format=json auth/approle/role/jenkins/secret-id | jq -r ".data.secret_id" > secret_id.txt
cat role_id.txt
vault write auth/approle/login role_id=$(cat role_id.txt)      secret_id=$(cat secret_id.txt)
vault token lookup hvs.CAESIHejrXUFK7-w5D72ZaQJfqtxfLf-2QjpFRUzS1R5yiLHGh4KHGh2cy5heHJSMUZHQ2N6RHJLbGF3bHNINWtWUmM
vault token lookup -format=json <your-token> | jq -r .data.policies > token_policies.txt
vault token lookup -format=json hvs.CAESIHejrXUFK7-w5D72ZaQJfqtxfLf-2QjpFRUzS1R5yiLHGh4KHGh2cy5heHJSMUZHQ2N6RHJLbGF3bHNINWtWUmM | jq -r .data.policies > token_policies.txt
cat token_policies.txt
export PROJECT_ID=$(gcloud config get-value project)
gsutil cp token_policies.txt gs://$PROJECT_ID
vault policy write test -<<EOF
path "auth/token/create" {
   capabilities = ["create", "read", "update", "delete", "list"]
}
EOF

vault token create -type=batch -policy=test -ttl=20m
vault token lookup <batch_token>
vault login <batch_token>
vault token lookup hvb.AAAAAQJK4K6SqhRlj3zysMT37iWpIUqIy_4Cpy_VlDnDkFv9kFO-Or37f5kTtKyWhFTnUo6UApH_gFSH1231f0b8cl6hfVyQ9SSjcr1A6LrG64-LLgh0LlqJUAcS-IxZQDAPVYSeastnf4IXdRwiRGdqVNP-N1R-VX9JFkc4hQ
vault login hvb.AAAAAQJK4K6SqhRlj3zysMT37iWpIUqIy_4Cpy_VlDnDkFv9kFO-Or37f5kTtKyWhFTnUo6UApH_gFSH1231f0b8cl6hfVyQ9SSjcr1A6LrG64-LLgh0LlqJUAcS-IxZQDAPVYSeastnf4IXdRwiRGdqVNP-N1R-VX9JFkc4hQ
vault write cubbyhole/token value="1234567890"
vault token create -policy=default
vault login hvs.mlI5bGdl9AzPx81K6q5icj9T
vault token revoke hvb.AAAAAQJK4K6SqhRlj3zysMT37iWpIUqIy_4Cpy_VlDnDkFv9kFO-Or37f5kTtKyWhFTnUo6UApH_gFSH1231f0b8cl6hfVyQ9SSjcr1A6LrG64-LLgh0LlqJUAcS-IxZQDAPVYSeastnf4IXdRwiRGdqVNP-N1R-VX9JFkc4hQ
vault write auth/approle/role/shipping policies="shipping"      token_type="batch"      token_ttl="20m"
vault read -format=json auth/approle/role/shipping/role-id     | jq -r ".data.role_id" > role_id.txt
cat role_id.txt
vault write -f -format=json auth/approle/role/shipping/secret-id | jq -r ".data.secret_id" > secret_id.txt
vault write auth/approle/login role_id=$(cat role_id.txt)      secret_id=$(cat secret_id.txt)
vault token lookup hvb.AAAAAQJri0wBfBU8yl9Xg2mmbKVTNNAJR-gdgivoQVZ3Qob4_VfVJsK7TVekBbcV4spFGI0zn21DAA_wa_48ELE_tAsrzLsBdGotzFXszMB25bRo6Aap8UwFPq3uhUmHrNL1CLP5vgfIIXm32BRL_dVZunWoG2FFXCxbi1dy6sAtn5ir4_LWHTmy9kuHG-jR6CwYg4_1YxSm1XGMi79gPALlL4t9
vault token create -policy=default
vault auth list -detailed
vault read sys/auth/token/tune
vault write sys/auth/token/tune default_lease_ttl=8h max_lease_ttl=720h
vault read sys/auth/token/tune
vault token create -policy=default
vault read sys/internal/counters/tokens
curl --header "X-Vault-Token:hvs.mlI5bGdl9AzPx81K6q5icj9T"        $VAULT_ADDR/v1/sys/internal/counters/tokens | jq .data
vault read sys/internal/counters/tokens
vault read sys/internal
vault read sys/internal/counters
vault read sys/auth/token/tune
vault read
vault read sys
dir sys
vault list
vault --help
vault status
vault list
vault token
vault read sys/auth/token/tune
vault --help
vault read sys/auth/token/tune
vault status
vault list sys
vault list sys/
vault list sys/internal
vault list sys/internal/
vault token capabilities sys/internal/counters/tokens
ault read sys/auth/token/tune
vault read sys/auth/token/tune
vault version
echo $VAULT_ADDR
vault status
vault token create
vault read sys/internal/counters/tokens
