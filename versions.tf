terraform {
  required_version = "= 1.3.9"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.42.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.18.1"
    }
  }
}

provider "google" {
  # Configuration options
  # Credentials configured in the Terraform workspace
  project = "ornate-magnet-376615"
}

provider "kubernetes" {
  host                   = module.gke_auth.host
  token                  = module.gke_auth.token
  cluster_ca_certificate = module.gke_auth.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    cluster_ca_certificate = module.gke_auth.cluster_ca_certificate
    host                   = module.gke_auth.host
    token                  = module.gke_auth.token
  }
}

module "gke_auth" {
  source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version              = "25.0.0"
  project_id           = "ornate-magnet-376615"
  cluster_name         = "autopilot-cluster-1"
  location             = "europe-west1"
  use_private_endpoint = false
}
