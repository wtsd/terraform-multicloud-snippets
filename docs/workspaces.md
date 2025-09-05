# Workspaces & Environments
Use Terraform **workspaces** to separate environments when state isolation is acceptable in a single backend.
```bash
terraform workspace new dev
terraform workspace select dev
```
For stricter isolation, use separate backends & state files per env.
