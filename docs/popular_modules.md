# Most‑used Terraform modules (quick cheatsheet)

This page lists **widely used community modules** from the Terraform Registry that cover common building blocks across AWS, GCP, and Azure.
Use these when you need production‑grade features fast. Always pin versions.

> Tip: Prefer modules with **many stars/downloads**, active maintenance, and clear upgrade notes.

---

## AWS — `terraform-aws-modules/*`

- **terraform-aws-modules/vpc/aws** — Battle-tested VPC with public/private subnets, NAT, routing, tags.
- **terraform-aws-modules/eks/aws** — EKS cluster + managed node groups; supports IRSA and common add‑ons wiring.
- **terraform-aws-modules/rds/aws** — RDS instances & clusters (parameter groups, subnet groups, options).
- **terraform-aws-modules/s3-bucket/aws** — S3 with encryption, versioning, lifecycle, access policies.
- **terraform-aws-modules/iam/aws** — IAM users, roles, policies (helpers for common patterns).
- **terraform-aws-modules/security-group/aws** — Reusable security groups with rule presets.
- **terraform-aws-modules/alb/aws** — ALB/NLB with listeners/target groups.
- **terraform-aws-modules/cloudfront/aws** — CDN distributions (OAC/Origins, logging, behaviors).
- **terraform-aws-modules/ec2-instance/aws** — EC2 instances (profiles, volumes, security groups).
- **terraform-aws-modules/autoscaling/aws** — Auto Scaling Groups + Launch Templates.
- **terraform-aws-modules/route53/aws** — Hosted zones and records.
- **terraform-aws-modules/lambda/aws** — Lambda functions and related IAM/permissions.

---

## GCP — `terraform-google-modules/*`

- **terraform-google-modules/network/google** — VPC networks, subnets, routes, firewall rules.
- **terraform-google-modules/kubernetes-engine/google** — GKE clusters/node pools and IAM wiring.
- **terraform-google-modules/project-factory/google** — Project creation with APIs, IAM, billing link.
- **terraform-google-modules/cloud-nat/google** — Cloud NAT for private instances and GKE nodes.
- **terraform-google-modules/cloud-router/google** — Cloud Router resources.
- **terraform-google-modules/sql-db/google** — Cloud SQL instances/users/backups/flags.
- **terraform-google-modules/vm/google** — Compute Engine VM instances and templates.

---

## Azure — `Azure/*` (incl. AVM = Azure Verified Modules)

- **Azure/network/azurerm** — Virtual Network, subnets, route tables, NSGs.
- **Azure/aks/azurerm** — Azure Kubernetes Service clusters.
- **Azure/storage/azurerm** — Storage Account, containers, lifecycle, encryption.
- **Azure/keyvault/azurerm** — Key Vaults, access policies, secrets.
- **Azure/app-service/azurerm** — App Service Plans/Web Apps.
- **Azure/sql/azurerm** — Azure SQL (servers, DBs, firewall).

> Note: Azure modules are moving toward **AVM (Azure Verified Modules)** naming. If a slug changes, search the Registry for the AVM equivalent.

---

## Usage pattern
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "prod"
  cidr = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  tags = { Project = "demo" }
}
```

**Good hygiene**
- Pin provider and module versions.
- Prefer remote state with locking and encryption.
- Keep inputs/outputs small; wrap heavy customization with your own higher‑level modules.
