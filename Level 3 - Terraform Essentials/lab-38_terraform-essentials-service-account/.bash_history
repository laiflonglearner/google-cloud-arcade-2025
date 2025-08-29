gcloud config set project qwiklabs-gcp-00-ceb345d1202d
gcloud config set compute/region us-east1
gcloud config set compute/zone us-east1-b
gcloud services enable iam.googleapis.comgcloud services enable iam.googleapis.com
gcloud services enable iam.googleapis.com
gcloud storage buckets create gs://qwiklabs-gcp-00-ceb345d1202d-tf-state --project=qwiklabs-gcp-00-ceb345d1202d --location=us-east1 --uniform-bucket-level-access
gsutil versioning set on gs://qwiklabs-gcp-00-ceb345d1202d-tf-state
mkdir terraform-service-account && cd $_
terraform {
}
provider "google" {
}
resource "google_service_account" "default" {
}
cat << EOF > main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  backend "gcs" {
    bucket = "qwiklabs-gcp-00-ceb345d1202d-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region 
}

resource "google_service_account" "default" {
  account_id   = "terraform-sa"
  display_name = "Terraform Service Account"
}

EOF

cat << EOF > variables.tf

variable "project_id" {
  type = string
  description = "The GCP project ID"
  default = "qwiklabs-gcp-00-ceb345d1202d"
}

variable "region" {
  type = string
  description = "The GCP region"
  default = "us-east1"
}

EOF

terraform init
terraform apply -auto-approve
gcloud iam service-accounts list --project=qwiklabs-gcp-00-ceb345d1202d
gcloud iam service-accounts list --project=qwiklabs-gcp-00-ceb345d1202d | cat > service_accounts.txt
cat service_accounts.txt
