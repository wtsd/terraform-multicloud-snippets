variable "name" { type = string }
variable "project" { type = string }
variable "region" { type = string }
variable "subnets" { type = list(object({ name = string, cidr = string })) }
