terraform {
  required_version = ">= 1.5.0"
  required_providers { google = { source = "hashicorp/google", version = "~> 5.0" } }
}
provider "google" { project = var.project, region = var.region }
resource "google_container_cluster" "cluster" {
  name               = var.name
  location           = var.region
  remove_default_node_pool = true
  initial_node_count = 1
  network    = var.network
  subnetwork = var.subnetwork
}
resource "google_container_node_pool" "pool" {
  cluster  = google_container_cluster.cluster.name
  location = var.region
  name     = "${var.name}-pool"
  node_count = var.min_nodes
  autoscaling { min_node_count = var.min_nodes, max_node_count = var.max_nodes }
}
