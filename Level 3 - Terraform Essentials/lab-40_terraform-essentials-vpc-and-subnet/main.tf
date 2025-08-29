
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  backend "gcs" {
    bucket = "qwiklabs-gcp-03-31d8dc458a2e-terraform-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "qwiklabs-gcp-03-31d8dc458a2e"
  region  = "us-east1"
}

resource "google_compute_network" "vpc_network" {
  name                    = "custom-vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_us" {
  name            = "subnet-us"
  ip_cidr_range   = "10.10.1.0/24"
  region          = "us-east1"
  network         = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_icmp" {
  name    = "allow-icmp"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}

