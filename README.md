# Terraform Multicloud Snippets & Reference Architectures

A starter repo with **Terraform** snippets and small **reference architectures** for **AWS**, **GCP**, and **Azure**—from one-off configs to minimal app/network stacks (EKS/GKE/AKS, 3-tier web, remote state).

---

> [!] WARNING!
> Designed for fast copy-paste, safe defaults, and easy customization. Everything here is intentionally **small** and **composable**.

## Quick start
```bash
# 1) pick an example (e.g., AWS S3 bucket)
export DIR=examples/aws/one-time/s3_versioned_bucket

# 2) format, init, validate
make fmt init DIR=$DIR

# 3) plan/apply (pass variables via VARS)
make plan  DIR=$DIR VARS='-var bucket_name=my-demo-bucket-123'
make apply DIR=$DIR VARS='-var bucket_name=my-demo-bucket-123'

# 4) destroy when done
make destroy DIR=$DIR VARS='-var bucket_name=my-demo-bucket-123'
```

## Credentials (summary)
- **AWS**: `aws configure` (or set `AWS_PROFILE` / `AWS_*` envs).
- **GCP**: `gcloud auth application-default login` or set `GOOGLE_APPLICATION_CREDENTIALS`.
- **Azure**: `az login` or set `ARM_*` envs.

See `docs/provider_setup.md` for details.

## Contents
```
.
├── docs/
│   ├── provider_setup.md
│   ├── workspaces.md
│   ├── modules.md
│   ├── security.md
│   ├── patterns.md
│   └── popular_modules.md          # new: curated Registry modules
├── modules/
│   ├── aws/ {vpc, eks}
│   ├── gcp/ {network, gke}
│   └── azure/ {vnet, aks}
├── examples/
│   ├── aws/
│   │   ├── one-time/ {s3_versioned_bucket, iam_user_with_policy}
│   │   ├── three-tier/
│   │   └── eks-minimal/
│   ├── gcp/
│   │   ├── one-time/ {gcs_bucket}
│   │   └── gke-minimal/
│   ├── azure/
│   │   ├── one-time/ {storage_account}
│   │   └── aks-minimal/
│   └── crosscloud/
│       └── state-backend/ {s3+dynamodb}
├── ci/github-actions/terraform.yml
├── Makefile
└── README.md
```

## Tooling
- `make fmt|init|validate|plan|apply|destroy`
- GitHub Action: `terraform fmt -check` + `terraform validate`

**UPD**: See `docs/popular_modules.md` for a curated list of popular Registry modules.
