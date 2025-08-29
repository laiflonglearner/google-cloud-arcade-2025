
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

