export MPC_PROJECT_ID=$(gcloud config get-value core/project)
echo $MPC_PROJECT_ID
gcloud services enable cloudkms.googleapis.com compute.googleapis.com confidentialcomputing.googleapis.com iamcredentials.googleapis.com artifactregistry.googleapis.com
gcloud kms keyrings create mpc-keys --location=global
gcloud kms keys create mpc-key --location=global   --keyring=mpc-keys --purpose=encryption --protection-level=hsm
gcloud kms keys add-iam-policy-binding   projects/$MPC_PROJECT_ID/locations/global/keyRings/mpc-keys/cryptoKeys/mpc-key   --member="user:$(gcloud config get-value account)"   --role='roles/cloudkms.cryptoKeyEncrypter'
echo -n "00000000000000000000000000000000" >> alice-key-share
echo -n "00000000000000000000000000000001" >> bob-key-share
gcloud kms encrypt     --key mpc-key     --keyring mpc-keys     --location global      --plaintext-file alice-key-share     --ciphertext-file alice-encrypted-key-share
gcloud kms encrypt     --key mpc-key     --keyring mpc-keys     --location global      --plaintext-file bob-key-share     --ciphertext-file bob-encrypted-key-share
gcloud storage buckets create gs://$MPC_PROJECT_ID-mpc-encrypted-keys --location=us-east1
gcloud storage cp alice-encrypted-key-share gs://$MPC_PROJECT_ID-mpc-encrypted-keys/
gcloud storage cp bob-encrypted-key-share gs://$MPC_PROJECT_ID-mpc-encrypted-keys/
gcloud iam service-accounts create trusted-mpc-account
gcloud kms keys add-iam-policy-binding mpc-key --keyring='mpc-keys' --location='global' --member="serviceAccount:trusted-mpc-account@$MPC_PROJECT_ID.iam.gserviceaccount.com" --role='roles/cloudkms.cryptoKeyDecrypter'
gcloud iam workload-identity-pools create trusted-workload-pool --location="global"
gcloud iam workload-identity-pools providers create-oidc attestation-verifier   --location="global"   --workload-identity-pool="trusted-workload-pool"   --issuer-uri="https://confidentialcomputing.googleapis.com/"   --allowed-audiences="https://sts.googleapis.com"   --attribute-mapping="google.subject='assertion.sub'"   --attribute-condition="assertion.swname == 'CONFIDENTIAL_SPACE' &&
    'STABLE' in assertion.submods.confidential_space.support_attributes &&
    assertion.submods.container.image_reference ==
    'us-east1-docker.pkg.dev/$MPC_PROJECT_ID/mpc-workloads/initial-workload-container:latest'
    && 'run-confidential-vm@$MPC_PROJECT_ID.iam.gserviceaccount.com' in
    assertion.google_service_accounts"
gcloud iam service-accounts add-iam-policy-binding trusted-mpc-account@$MPC_PROJECT_ID.iam.gserviceaccount.com --role=roles/iam.workloadIdentityUser --member="principalSet://iam.googleapis.com/projects/$(gcloud projects describe $MPC_PROJECT_ID --format="value(projectNumber)")/locations/global/workloadIdentityPools/trusted-workload-pool/*"
gcloud iam service-accounts create run-confidential-vm
gcloud iam service-accounts add-iam-policy-binding   run-confidential-vm@$MPC_PROJECT_ID.iam.gserviceaccount.com   --member="user:$(gcloud config get-value account)"   --role='roles/iam.serviceAccountUser'
gcloud projects add-iam-policy-binding $MPC_PROJECT_ID   --member=serviceAccount:run-confidential-vm@$MPC_PROJECT_ID.iam.gserviceaccount.com   --role=roles/logging.logWriter
gcloud compute instances create-with-container mpc-lab-ethereum-node    --zone=us-east1-c   --tags=http-server   --shielded-secure-boot   --shielded-vtpm   --shielded-integrity-monitoring   --container-image=docker.io/trufflesuite/ganache:v7.7.3   --container-arg=--wallet.accounts=\"0x0000000000000000000000000000000000000000000000000000000000000001,0x21E19E0C9BAB2400000\"   --container-arg=--port=80   --machine-type=e2-medium
gcloud compute instances create-with-container mpc-lab-ethereum-node    --zone=us-east1-c   --tags=http-server   --shielded-secure-boot   --shielded-vtpm   --shielded-integrity-monitoring   --container-image=docker.io/trufflesuite/ganache:v7.7.3   --container-arg=--wallet.accounts=\"0x0000000000000000000000000000000000000000000000000000000000000001,0x21E19E0C9BAB2400000\"   --container-arg=--port=80   --machine-type=e2-medium
gcloud storage buckets create gs://$MPC_PROJECT_ID-mpc-results-storage --location=us-east1
gcloud storage buckets create gs://$MPC_PROJECT_ID-mpc-results-storage --location=us-east1
gsutil iam ch   serviceAccount:run-confidential-vm@$MPC_PROJECT_ID.iam.gserviceaccount.com:objectCreator   gs://$MPC_PROJECT_ID-mpc-results-storage
gsutil iam ch   serviceAccount:trusted-mpc-account@$MPC_PROJECT_ID.iam.gserviceaccount.com:objectViewer   gs://$MPC_PROJECT_ID-mpc-encrypted-keys
gcloud artifacts repositories create mpc-workloads   --repository-format=docker --location=us-east1
gcloud auth configure-docker us-east1-docker.pkg.dev
docker build -t us-east1-docker.pkg.dev/$MPC_PROJECT_ID/mpc-workloads/initial-workload-container:latest mpc-ethereum-demo
docker push us-east1-docker.pkg.dev/$MPC_PROJECT_ID/mpc-workloads/initial-workload-container:latest
gcloud artifacts repositories add-iam-policy-binding mpc-workloads     --location=us-east1     --member=serviceAccount:run-confidential-vm@$MPC_PROJECT_ID.iam.gserviceaccount.com     --role=roles/artifactregistry.reader
gcloud projects add-iam-policy-binding $MPC_PROJECT_ID --member=serviceAccount:run-confidential-vm@$MPC_PROJECT_ID.iam.gserviceaccount.com --role=roles/confidentialcomputing.workloadUser
gcloud projects add-iam-policy-binding $MPC_PROJECT_ID --member=serviceAccount:run-confidential-vm@$MPC_PROJECT_ID.iam.gserviceaccount.com --role=roles/confidentialcomputing.workloadUser
gcloud compute instances create mpc-cvm --confidential-compute   --shielded-secure-boot   --maintenance-policy=TERMINATE --scopes=cloud-platform  --zone=us-east1-c   --image-project=confidential-space-images   --image-family=confidential-space   --service-account=run-confidential-vm@$MPC_PROJECT_ID.iam.gserviceaccount.com   --metadata ^~^tee-image-reference=us-east1-docker.pkg.dev/$MPC_PROJECT_ID/mpc-workloads/initial-workload-container:latest~tee-restart-policy=Never~tee-env-NODE_URL=$(gcloud compute instances describe mpc-lab-ethereum-node --format='get(networkInterfaces[0].networkIP)' --zone=us-east1-c)~tee-env-RESULTS_BUCKET=$MPC_PROJECT_ID-mpc-results-storage~tee-env-KEY_BUCKET=$MPC_PROJECT_ID-mpc-encrypted-keys~tee-env-MPC_PROJECT_ID=$MPC_PROJECT_ID~tee-env-MPC_PROJECT_NUMBER=$(gcloud projects describe $MPC_PROJECT_ID --format="value(projectNumber)")
