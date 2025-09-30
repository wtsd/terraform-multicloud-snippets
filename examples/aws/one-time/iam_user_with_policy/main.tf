terraform {
  required_version = ">= 1.5.0"
  required_providers { aws = { source = "hashicorp/aws", version = "~> 5.0" } }
}
provider "aws" {}
resource "aws_iam_user" "user" { name = var.user_name }
resource "aws_iam_access_key" "key" { user = aws_iam_user.user.name }
resource "aws_iam_user_policy" "inline" {
  name   = "AllowListOwnBuckets"
  user   = aws_iam_user.user.name
  policy = jsonencode({ Version = "2012-10-17", Statement = [{ Action = ["s3:ListAllMyBuckets"], Effect = "Allow", Resource = "*" }] })
}
