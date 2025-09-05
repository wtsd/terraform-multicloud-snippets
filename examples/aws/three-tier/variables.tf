variable "name"        { type = string, default = "demo3tier" }
variable "region"      { type = string, default = "us-east-1" }
variable "cidr_block"  { type = string, default = "10.42.0.0/16" }
variable "instance_type" { type = string, default = "t3.micro" }
variable "db_username" { type = string, default = "demo" }
variable "db_password" { type = string, sensitive = true }
