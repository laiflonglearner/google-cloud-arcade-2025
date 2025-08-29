
output "network_name" {
  value       = google_compute_network.vpc_network.name
  description = "The name of the VPC network"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet_us.name
  description = "The name of the subnetwork"
}

