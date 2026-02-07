terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "instance_count" {
  description = "Number of VM instances to create"
  type        = number
  default     = 24
}

resource "google_compute_instance" "vm_instances" {
  count        = var.instance_count
  name         = "e2-micro-instance-${count.index + 1}"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    
    # Uncomment to assign external IP
    access_config {
    }
  }

  # Optional: Add labels for better organization
  labels = {
    environment = "dev"
    managed_by  = "terraform"
  }

  # Optional: Add metadata
  metadata = {
    serial-port-enable = "true"
  }

  tags = ["http-server", "https-server"]
}

output "instance_names" {
  description = "Names of the created instances"
  value       = google_compute_instance.vm_instances[*].name
}

output "instance_ips" {
  description = "Internal IP addresses of the instances"
  value       = google_compute_instance.vm_instances[*].network_interface[0].network_ip
}

output "external_ips" {
  description = "External IP addresses of the instances"
  value       = google_compute_instance.vm_instances[*].network_interface[0].access_config[0].nat_ip
}