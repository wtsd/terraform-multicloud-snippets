# Security & State
- Prefer **remote state** + **locking** (S3 + DynamoDB, GCS, or Azure storage).
- Enable **server-side encryption** on state backends.
- Never commit `*.tfvars` with secrets.
- Limit IAM by least-privilege.
