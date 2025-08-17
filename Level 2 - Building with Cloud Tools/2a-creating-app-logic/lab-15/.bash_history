cd policy-library/
cp samples/iam_service_accounts_only.yaml policies/constraints
git clone https://github.com/GoogleCloudPlatform/policy-library.git
cd policy-library/
cp samples/iam_service_accounts_only.yaml policies/constraints
cat policies/constraints/iam_service_accounts_only.yaml
nano main.tf
terraform init
terraform plan -out=test.tfplan
terraform show -json ./test.tfplan > ./tfplan.json
sudo apt-get install google-cloud-sdk-terraform-tools
gcloud beta terraform vet tfplan.json --policy-library=.
apiVersion: constraints.gatekeeper.sh/v1alpha1
kind: GCPIAMAllowedPolicyMemberDomainsConstraintV1
metadata:
spec:
terraform plan -out=test.tfplan
cat policies/constraints/iam_service_accounts_only.yaml
cat main.tf
sudo apt-get install google-cloud-sdk-terraform-tools
terraform show -json ./test.tfplan > ./tfplan.json
gcloud beta terraform vet tfplan.json --policy-library=.
terraform plan -out=test.tfplan
ls -a
cd policy-library
terraform plan -out=test.tfplan
gcloud beta terraform vet tfplan.json --policy-library=.
terraform apply test.tfplan
