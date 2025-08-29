gcloud config set project qwiklabs-gcp-02-4707e17cebac
gcloud services enable firestore.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud storage buckets create gs://qwiklabs-gcp-02-4707e17cebac-tf-state --location=us
cat << EOF > main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  backend "gcs" {
    bucket = "qwiklabs-gcp-02-4707e17cebac-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "qwiklabs-gcp-02-4707e17cebac"
  region  = "us-central1"
}

resource "google_firestore_database" "default" {
  name     = "default"
  project  = "qwiklabs-gcp-02-4707e17cebac"
  location_id = "nam5"
  type     = "FIRESTORE_NATIVE"
}

output "firestore_database_name" {
  value       = google_firestore_database.default.name
  description = "The name of the Cloud Firestore database."
}

EOF

cat << EOF > variables.tf

variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project."
  default     = "qwiklabs-gcp-02-4707e17cebac"
}

variable "bucket_name" {
  type        = string
  description = "Bucket name for terraform state"
  default     = "qwiklabs-gcp-02-4707e17cebac-tf-state"
}

EOF

cat << EOF > outputs.tf

output "project_id" {
  value       = var.project_id
  description = "The ID of the Google Cloud project."
}

output "bucket_name" {
  value       = var.bucket_name
  description = "The name of the bucket to store terraform state."
}

EOF

terraform init
terraform plan
terraform apply
