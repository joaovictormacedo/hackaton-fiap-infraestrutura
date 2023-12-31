variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "Google Cloud zone"
  type        = string
  default     = "us-east1-b"
}

variable "project_name" {
  description = "GCP Project name"
  type        = string
}