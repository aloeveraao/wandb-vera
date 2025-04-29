variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Google region"
}

variable "zone" {
  type        = string
  description = "Google zone"
}

variable "namespace" {
  type        = string
  description = "Namespace prefix used for resources"
}

variable "domain_name" {
  type        = string
  description = "Domain name for accessing the Weights & Biases UI."
}

variable "subdomain" {
  type        = string
  description = "Subdomain for access the Weights & Biases UI."
}

variable "license" {
  type        = string
  description = "W&B License"
}

variable "gke_max_node_count" {
  type        = number
  description = "Maximum number of nodes in the GKE cluster"
}

variable "gke_min_node_count" {
  type        = number
  description = "Minimum number of nodes in the GKE cluster"
}