variable "bucket_name" { type = string }
variable "dynamodb_table" { type = string, default = "terraform-locks" }
variable "region" { type = string, default = "us-east-1" }
