curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install vault
export VAULT_ADDR='http://127.0.0.1:8200'
vault status
vault login token=hvs.4ROmcwW7x71QowwAsZ53fifG
vault secrets list
vault auth enable userpass
vault write auth/userpass/users/example-user password=password!
vault login -method=userpass username=example-user password=password!
vault token capabilities hvs.CAESIHxJQFkgTForhq5GO6oetwwes4LQ2jlg6Twd_rzqDhKHGh4KHGh2cy5QUnl1a2ZESjlZeW1lcUhhRFdqRzA5ME4 sys/policies/acl > token_capabilities.txt
export PROJECT_ID=$(gcloud config get-value project)
gsutil cp *.txt gs://$PROJECT_ID
cat token_capabilities.txt
vault policy list > policies.txt
vault policy list
vault login -method=userpass username=example-user password=password!
vault token capabilities hvs.CAESIHxJQFkgTForhq5GO6oetwwes4LQ2jlg6Twd_rzqDhKHGh4KHGh2cy5QUnl1a2ZESjlZeW1lcUhhRFdqRzA5ME4 sys/policies/acl > token_capabilities.txt
cat token_capabilities.txt
vault login token=hvs.4ROmcwW7x71QowwAsZ53fifG
vault secrets list
vault auth enable userpass
vault write auth/userpass/users/example-user password=password!
vault login -method=userpass username=example-user password=password!
vault token capabilities hvs.CAESIHxJQFkgTForhq5GO6oetwwes4LQ2jlg6Twd_rzqDhKHGh4KHGh2cy5QUnl1a2ZESjlZeW1lcUhhRFdqRzA5ME4 sys/policies/acl > token_capabilities.txt
cat token_capabilities.txt
vault login token=hvs.4ROmcwW7x71QowwAsZ53fifG
vault secrets list
vault login -method=userpass username=example-user password=password!
vault token capabilities hvs.CAESIHxJQFkgTForhq5GO6oetwwes4LQ2jlg6Twd_rzqDhKHGh4KHGh2cy5QUnl1a2ZESjlZeW1lcUhhRFdqRzA5ME4 sys/policies/acl > token_capabilities.txt
vault token capabilities hvs.CAESIH4IsYU7AGVe2I3Srn06oitqvT3_DvakydSVTopVJ51MGh4KHGh2cy5PcjJ3T0Q2MjJoazM3N0Vic3F0ZUtWRWo sys/policies/acl > token_capabilities.txt
cat token_capabilities.txt
export PROJECT_ID=$(gcloud config get-value project)
gsutil cp *.txt gs://$PROJECT_ID
cat token_capabilities.txt
vault server -dev
export PROJECT_ID=$(gcloud config get-value project)
cat token_capabilities.txt
export PROJECT_ID=$(gcloud config get-value project)
gsutil cp *.txt gs://$PROJECT_ID
vault policy list > policies.txt
cat policies.txt
vault policy list
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install vault
export VAULT_ADDR='http://127.0.0.1:8200'
vault status
vault login token=hvs.khkjEF0aPyywLnfhiVmVEI4R
vault secrets list
vault auth enable userpass
vault write auth/userpass/users/example-user password=password!
vault login -method=userpass username=example-user password=password!
vault secrets list
vault policy list
vault login -method=userpass username=example-user password=password!
vault policy list > policies.txt
cat policies.txt
vault token capabilities hvs.CAESIJIDD-O6Rna8lQ57jO_wBqfyMjZ9drf3M88zrT4f-chpGh4KHGh2cy5xNzVESTBnZDVYSkVZaU9odFp3UHpXR04 sys/policies/acl > token_capabilities.txt
cat token_capabilities.txt
export PROJECT_ID=$(gcloud config get-value project)
gsutil cp *.txt gs://$PROJECT_ID
vault login token=hvs.khkjEF0aPyywLnfhiVmVEI4R
vault read sys/policy
vault policy write policy-name policy-file.hcl
vault policy write policy-name example-policy.hcl
tee example-policy.hcl <<EOF
# List, create, update, and delete key/value secrets
path "secret/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage secrets engines
path "sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List existing secrets engines.
path "sys/mounts"
{
  capabilities = ["read"]
}
EOF

vault policy write policy-name example-policy.hcl
tee example-policy.hcl <<EOF
# List, create, update, and delete key/value secrets
path "secret/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage secrets engines
path "sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List existing secrets engines.
path "sys/mounts"
{
  capabilities = ["read"]
}

# List auth methods
path "sys/auth"
{
  capabilities = ["read"]
}
EOF

cat example-policy.hcl
vault write sys/policy/example-policy policy=@example-policy.hcl
gsutil cp example-policy.hcl gs://$PROJECT_ID
vault delete sys/policy/example-policy
vault policy list
vault write auth/userpass/users/firstname-lastname     password="s3cr3t!"     policies="default, demo-policy"
vault login -method="userpass" username="firstname-lastname" password="s3cr3t!"
vault login hvs.khkjEF0aPyywLnfhiVmVEI4R
vault token create -policy=dev-readonly -policy=logs
vault write auth/userpass/users/admin     password="admin123"     policies="admin"
vault write auth/userpass/users/app-dev     password="appdev123"     policies="appdev"
vault write auth/userpass/users/security     password="security123"     policies="security"
vault kv put secret/security/first username=password
vault kv put secret/security/second username=password
vault kv put secret/appdev/first username=password
vault kv put secret/appdev/beta-app/second username=password
vault kv put secret/admin/first admin=password
vault kv put secret/admin/supersecret/second admin=password
vault login -method="userpass" username="app-dev" password="appdev123"
vault kv get secret/appdev/first
vault kv get secret/appdev/beta-app/second
vault kv put secret/appdev/appcreds credentials=creds123
vault kv destroy -versions=1 secret/appdev/appcreds
vault kv get secret/security/first
vault kv list secret/
vault login -method="userpass" username="security" password="security123"
vault kv get secret/security/first
vault kv get secret/security/second
vault kv put secret/security/supersecure/bigsecret secret=idk
vault kv destroy -versions=1 secret/security/supersecure/bigsecret
vault kv get secret/appdev/first
vault kv list secret/
vault secrets enable -path=supersecret kv
vault kv get secret/admin/first
vault kv list secret/admin
vault login -method="userpass" username="admin" password="admin123"
vault kv get secret/admin/first
vault kv get secret/security/first
vault kv put secret/webserver/credentials web=awesome
vault kv destroy -versions=1 secret/webserver/credentials
vault kv get secret/appdev/first
vault kv list secret/appdev/
vault policy list
vault policy list > policies-update.txt
gsutil cp policies-update.txt gs://$PROJECT_ID
vault auth enable gcp
vault auth list
