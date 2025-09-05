terraform {
  required_version = ">= 1.5.0"
  required_providers { azurerm = { source = "hashicorp/azurerm", version = "~> 3.100" } }
}
provider "azurerm" { features {} }
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  default_node_pool { name = "default", node_count = var.node_count, vm_size = "Standard_B2s" }
  identity { type = "SystemAssigned" }
}
