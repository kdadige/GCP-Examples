variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "instance_count" {
  description = "Number of VM instances to create"
  type        = number
  default     = 24
}