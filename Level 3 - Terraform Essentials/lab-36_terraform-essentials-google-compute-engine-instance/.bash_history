gcloud config list project
terraform version
gcloud auth login
gcloud config set project qwiklabs-gcp-03-35bbab2c516e
gsutil mb -l us-east1 gs://qwiklabs-gcp-03-35bbab2c516e-tf-state
gsutil versioning set on gs://qwiklabs-gcp-03-35bbab2c516e-tf-state
cat << EOF > main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  backend "gcs" {
    bucket = "qwiklabs-gcp-03-35bbab2c516e-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "default" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = "default"

    access_config {
    }
  }
}

EOF

cat << EOF > variables.tf

variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project"
  default = "qwiklabs-gcp-03-35bbab2c516e"
}

variable "region" {
  type        = string
  description = "The region to deploy resources in"
  default     = "us-east1"
}

variable "zone" {
  type        = string
  description = "The zone to deploy resources in"
  default     = "us-east1-c"
}

EOF

terraform init
terraform plan
terraform apply -auto-approve
gcloud compute instances list
gcloud compute instances list | cat > instances.txt
cat instance.txt
cat instances.txt
