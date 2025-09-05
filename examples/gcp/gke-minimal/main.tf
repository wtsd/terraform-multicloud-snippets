terraform {
  required_version = ">= 1.5.0"
  required_providers { google = { source = "hashicorp/google", version = "~> 5.0" } }
}
provider "google" { project = var.project, region = var.region }
module "net" {
  source  = "../../../modules/gcp/network"
  name    = "demo-net"
  project = var.project
  region  = var.region
  subnets = [{ name = "demo-subnet", cidr = "10.70.0.0/20" }]
}
module "gke" {
  source     = "../../../modules/gcp/gke"
  name       = var.name
  project    = var.project
  region     = var.region
  network    = module.net.network_name
  subnetwork = module.net.subnet_names[0]
}
