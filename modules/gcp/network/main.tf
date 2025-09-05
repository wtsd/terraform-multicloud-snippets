terraform {
  required_version = ">= 1.5.0"
  required_providers { google = { source = "hashicorp/google", version = "~> 5.0" } }
}
provider "google" { project = var.project, region = var.region }
resource "google_compute_network" "vpc" {
  name = var.name
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "subnets" {
  for_each      = { for s in var.subnets : s.name => s }
  name          = each.value.name
  ip_cidr_range = each.value.cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}
