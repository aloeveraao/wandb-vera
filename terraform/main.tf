terraform {
  required_version = ">= 0.14"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.79.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.79.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "google" {
 project = var.project_id
 region  = var.region
 zone    = var.zone
}

provider "google-beta" {
 project = var.project_id
 region  = var.region
 zone    = var.zone
}

data "google_client_config" "current" {}

provider "kubernetes" {
  host                   = "https://${module.wandb.cluster_endpoint}"
  cluster_ca_certificate = base64decode(module.wandb.cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}

# New Helm provider block
provider "helm" {
  kubernetes {
    host                   = "https://${module.wandb.cluster_endpoint}"
    cluster_ca_certificate = base64decode(module.wandb.cluster_ca_certificate)
    token                  = data.google_client_config.current.access_token
  }
}

# Spin up all required services
module "wandb" {
  source  = "wandb/wandb/google"
  version = "~> 9.0"

  namespace   = var.namespace
  license     = var.license
  domain_name = var.domain_name
  subdomain   = var.subdomain
  gke_min_node_count = var.gke_min_node_count
  gke_max_node_count = var.gke_max_node_count

}

# You'll want to update your DNS with the provisioned IP address
output "url" {
  value = module.wandb.url
}

output "address" {
  value = module.wandb.address
}

output "bucket_name" {
  value = module.wandb.bucket_name
}

