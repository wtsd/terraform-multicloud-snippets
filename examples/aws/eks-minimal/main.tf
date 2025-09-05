terraform {
  required_version = ">= 1.5.0"
  required_providers { aws = { source = "hashicorp/aws", version = "~> 5.0" } }
}
provider "aws" {}
module "vpc" {
  source     = "../../../modules/aws/vpc"
  name       = var.name
  cidr_block = var.cidr_block
}
module "eks" {
  source             = "../../../modules/aws/eks"
  name               = var.name
  region             = var.region
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}
