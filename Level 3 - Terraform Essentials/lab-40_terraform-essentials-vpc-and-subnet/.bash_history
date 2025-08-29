gcloud config set project qwiklabs-gcp-03-31d8dc458a2e
gcloud config set compute/region us-east1
gcloud config set compute/zone us-east1-b
gcloud storage buckets create gs://qwiklabs-gcp-03-31d8dc458a2e-terraform-state --project=qwiklabs-gcp-03-31d8dc458a2e --location=us
gcloud services enable cloudresourcemanager.googleapis.com --project=qwiklabs-gcp-03-31d8dc458a2e
# To enable firewall policies for the VPC
terraform {
}
provider "google" {
}
resource "google_compute_network" "vpc_network" {
}
resource "google_compute_subnetwork" "subnet_us" {
}
resource "google_compute_firewall" "allow_ssh" {
}
resource "google_compute_firewall" "allow_icmp" {
}
EOF
# To enable firewall policies for the VPC
terraform {
}
provider "google" {
}
resource "google_compute_network" "vpc_network" {
}
resource "google_compute_subnetwork" "subnet_us" {
}
resource "google_compute_firewall" "allow_ssh" {
}
resource "google_compute_firewall" "allow_icmp" {
}
EOF
# To enable firewall policies for the VPC
terraform {
}
provider "google" {
}
resource "google_compute_network" "vpc_network" {
}
resource "google_compute_subnetwork" "subnet_us" {
}
resource "google_compute_firewall" "allow_ssh" {
}
resource "google_compute_firewall" "allow_icmp" {
}
EOF
# To enable firewall policies for the VPC
cat << EOF > main.tf

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

EOF

cat << EOF > variables.tf

variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project"
  default     = "qwiklabs-gcp-03-31d8dc458a2e"
}

variable "region" {
  type        = string
  description = "The region to deploy resources in"
  default     = "us-east1"
}

EOF

cat << EOF > outputs.tf

output "network_name" {
  value       = google_compute_network.vpc_network.name
  description = "The name of the VPC network"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet_us.name
  description = "The name of the subnetwork"
}

EOF

terraform init
terraform plan
terraform apply --auto-approve
