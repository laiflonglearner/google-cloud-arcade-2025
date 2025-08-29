
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

