gcloud config set project qwiklabs-gcp-03-336794595007
gcloud config set compute/region us-east1
gcloud config set compute/zone us-east1-c
gcloud storage buckets create gs://qwiklabs-gcp-03-336794595007-tf-state --project=qwiklabs-gcp-03-336794595007 --location=us-east1 --uniform-bucket-level-access
gsutil versioning set on gs://qwiklabs-gcp-03-336794595007-tf-state
mkdir terraform-gcs && cd $_
cat << EOF > main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }

  backend "gcs" {
    bucket = "qwiklabs-gcp-03-336794595007-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "qwiklabs-gcp-03-336794595007"
  region  = "us-east1"
}

resource "google_storage_bucket" "default" {
  name          = "qwiklabs-gcp-03-336794595007-my-terraform-bucket"
  location      = "us-east1"
  force_destroy = true

  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

EOF

terraform init
terraform plan
terraform apply -auto-approve
gsutil ls gs://qwiklabs-gcp-03-336794595007-my-terraform-bucket
ls
