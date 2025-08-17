curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install vault
nano config.hcl
mkdir -p ./vault/data
export VAULT_ADDR='http://127.0.0.1:8200'
vault operator init
vault operator unseal
vault login hvs.hV1gFrnbVHUiU6W2QbDVXrXX
vault write gcp/config credentials=@qwiklabs-gcp-04-412f6a6ac138-a2bc37d49b2a.json  ttl=3600  max_ttl=86400
ls
vault write gcp/config credentials=@qwiklabs-gcp-04-92258e6172e1-f723a532c0f8.json  ttl=3600  max_ttl=86400
vault status
vault secrets enable gcp
vault write gcp/config credentials=@qwiklabs-gcp-04-92258e6172e1-f723a532c0f8.json  ttl=3600  max_ttl=86400
nano bindings.hcl
vault write gcp/roleset/my-token-roleset     project="qwiklabs-gcp-04-92258e6172e1"     secret_type="access_token"      token_scopes="https://www.googleapis.com/auth/cloud-platform"     bindings=@bindings.hcl
vault read gcp/roleset/my-token-roleset/token
curl   'https://storage.googleapis.com/storage/v1/b/qwiklabs-gcp-04-92258e6172e1'   --header 'Authorization: Bearer <OAUTH2_TOKEN>'   --header 'Accept: application/json'
curl -X GET   -H "Authorization: Bearer <OAUTH2_TOKEN>"   -o "sample.txt"   "https://storage.googleapis.com/storage/v1/b/<BUCKET_NAME>/o/sample.txt?alt=media"
cat sample.txt
curl   'https://storage.googleapis.com/storage/v1/b/qwiklabs-gcp-04-92258e6172e1'   --header 'Authorization: Bearer ya29.c.c0ASRK0Gb8hLscQ1PbmiWvlgXCj06BLHbWmJrFVHkck5MetyvSno8N3FvJVjJTcoach6EwRLJ1QQp09P6_Gfl6WEHIJlVcD6t5bPIXOTwAtXLkOmkChGOVjB32eGfPxku9ccCIM7FNcuxjt1NH-vt612eO3mQQOhsQDLlYtrwz-IvL4C9BzNQ6rq05NFHHaqeVXr8zjChrAHuzln7JdG_XFueYkmj-FsHpKxlILlwfxxAKinsJ85UN9NBqqrfbl9lLQ0QvXBa46nlk2lmMkXtfk-ETDUeRzWtIR4WPJDvfN_PjU09CwEU-me_PM5QQagXzmcR-__nex3o-f_9J8qiNkiTzHngVLlcsmr82evXbLw4-9IOgwrBA0rL0H385DijJ-uJkkUufsjtjsRnugW6MI1rsvVadzszeyursmtghW_i3swta91VQrXwhjtfXmOROhMXY15f4JO4Fd7u1jmrlUMekFbMV47UbjnzX0w2_u0fUcyX159F87eF3O3e4Im_y0-jwVM4_kWrsekbgtfkVkX4xBcpB9YSkW0qOsb59shquOoFVB7o547WqR4oIaccegWWh2cabe_t6fUxwMx-zRwOUki1veBOkrWFFo5VjVxB5jQzqMwhpByzseZrdmev8bSV_ZleweBMm2caiMio9nv1cpF3i-QUa4Q7gRjSYJ4eFnr-cuiF1hc1bf8e0dp7lVZRSU4_0UqgV9BR-gcyzoU5XFrFkjsyixoIopUeg8JB07_SXyrJ2p3aoOQRchJzfoS_dQ5s1pZVoJo2Xpn3-BM-ylwSZIxMQ_J9vVXnufZ9u56qsU9p-3tdpO-ga-x8eFWW9kFeUdk3ZbXnI_cgSOr3tU1F2cJFlOs6ZpuFpwz4dzUVlFSbIuvXQwcasBY_B5_k-208Ug2d2ndswxxubFd3VMmmcI9qOx4oep3F97-qkUuirunQzoRsgFOMryVBucMiVJ6Zugw8fzumWiI3fdR4JlW4B3Z828ISQaV81e8vy_u67oRos_Fv'   --header 'Accept: application/json'
curl -X GET   -H "Authorization: Bearer ya29.c.c0ASRK0Gb8hLscQ1PbmiWvlgXCj06BLHbWmJrFVHkck5MetyvSno8N3FvJVjJTcoach6EwRLJ1QQp09P6_Gfl6WEHIJlVcD6t5bPIXOTwAtXLkOmkChGOVjB32eGfPxku9ccCIM7FNcuxjt1NH-vt612eO3mQQOhsQDLlYtrwz-IvL4C9BzNQ6rq05NFHHaqeVXr8zjChrAHuzln7JdG_XFueYkmj-FsHpKxlILlwfxxAKinsJ85UN9NBqqrfbl9lLQ0QvXBa46nlk2lmMkXtfk-ETDUeRzWtIR4WPJDvfN_PjU09CwEU-me_PM5QQagXzmcR-__nex3o-f_9J8qiNkiTzHngVLlcsmr82evXbLw4-9IOgwrBA0rL0H385DijJ-uJkkUufsjtjsRnugW6MI1rsvVadzszeyursmtghW_i3swta91VQrXwhjtfXmOROhMXY15f4JO4Fd7u1jmrlUMekFbMV47UbjnzX0w2_u0fUcyX159F87eF3O3e4Im_y0-jwVM4_kWrsekbgtfkVkX4xBcpB9YSkW0qOsb59shquOoFVB7o547WqR4oIaccegWWh2cabe_t6fUxwMx-zRwOUki1veBOkrWFFo5VjVxB5jQzqMwhpByzseZrdmev8bSV_ZleweBMm2caiMio9nv1cpF3i-QUa4Q7gRjSYJ4eFnr-cuiF1hc1bf8e0dp7lVZRSU4_0UqgV9BR-gcyzoU5XFrFkjsyixoIopUeg8JB07_SXyrJ2p3aoOQRchJzfoS_dQ5s1pZVoJo2Xpn3-BM-ylwSZIxMQ_J9vVXnufZ9u56qsU9p-3tdpO-ga-x8eFWW9kFeUdk3ZbXnI_cgSOr3tU1F2cJFlOs6ZpuFpwz4dzUVlFSbIuvXQwcasBY_B5_k-208Ug2d2ndswxxubFd3VMmmcI9qOx4oep3F97-qkUuirunQzoRsgFOMryVBucMiVJ6Zugw8fzumWiI3fdR4JlW4B3Z828ISQaV81e8vy_u67oRos_Fv"   -o "sample.txt"   "https://storage.googleapis.com/storage/v1/b/qwiklabs-gcp-04-92258e6172e1/o/sample.txt?alt=media"
cat sample.txt
vault write gcp/roleset/my-key-roleset     project="qwiklabs-gcp-04-92258e6172e1"     secret_type="service_account_key"      bindings=@bindings.hcl
vault read gcp/roleset/my-key-roleset/key
vault write gcp/static-account/my-token-account     service_account_email="qwiklabs-gcp-04-92258e6172e1@qwiklabs-gcp-04-92258e6172e1.iam.gserviceaccount.com"     secret_type="access_token"      token_scopes="https://www.googleapis.com/auth/cloud-platform"     bindings=@bindings.hcl
vault write gcp/static-account/my-key-account     service_account_email="qwiklabs-gcp-04-92258e6172e1@qwiklabs-gcp-04-92258e6172e1.iam.gserviceaccount.com"     secret_type="service_account_key"      bindings=@bindings.hcl
