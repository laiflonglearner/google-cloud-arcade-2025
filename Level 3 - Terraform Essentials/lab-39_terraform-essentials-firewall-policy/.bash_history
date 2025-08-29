gcloud config set project qwiklabs-gcp-04-7785e0a49fdd
gcloud config set compute/region us-west1
gcloud config set compute/zone us-west1-c
gcloud storage buckets create gs://qwiklabs-gcp-04-7785e0a49fdd-tf-state --project=qwiklabs-gcp-04-7785e0a49fdd --location=us-west1 --uniform-bucket-level-access
gsutil versioning set on gs://qwiklabs-gcp-04-7785e0a49fdd-tf-state
mkdir terraform-firewall && cd $_
# This configuration creates a firewall rule named `allow-ssh-from-anywhere` that allows TCP traffic on port 22 from any source IP address (0.0.0.0/0) to instances tagged with `ssh-allowed`.
cat << EOF > firewall.tf

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-from-anywhere"
  network = "default"
  project = "qwiklabs-gcp-04-7785e0a49fdd"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-allowed"]
}

EOF

# This creates variables for the project ID, bucket name, and region that will be used in `firewall.tf` and `main.tf`
cat << EOF > variables.tf

variable "project_id" {
  type = string
  default = "qwiklabs-gcp-04-7785e0a49fdd"
}

variable "bucket_name" {
  type = string
  default = "qwiklabs-gcp-04-7785e0a49fdd-tf-state"
}

variable "region" {
  type = string
  default = "us-west1"
}

EOF

# This outputs the name of the firewall rule.
cat << EOF > outputs.tf

output "firewall_name" {
  value = google_compute_firewall.allow_ssh.name
}

EOF

terraform init 
terraform plan
terraform apply
