terraform {
  required_version = ">= 1.5.0"
  required_providers { azurerm = { source = "hashicorp/azurerm", version = "~> 3.100" } }
}
provider "azurerm" { features {} }
module "aks" {
  source              = "../../../modules/azure/aks"
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.name
}
