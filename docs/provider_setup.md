# Provider setup & auth

## AWS
- Install AWS CLI
- Configure:
  ```bash
  aws configure
  # or
  export AWS_PROFILE=default
  ```

## GCP
- Install gcloud
- Auth:
  ```bash
  gcloud auth application-default login
  export GOOGLE_PROJECT=my-project-id
  ```
- For service accounts: set `GOOGLE_APPLICATION_CREDENTIALS=/path/key.json`.

## Azure
- Install Azure CLI
- Auth:
  ```bash
  az login
  az account set --subscription <SUBSCRIPTION_ID>
  ```
