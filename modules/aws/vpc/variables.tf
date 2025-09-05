variable "name" { type = string }
variable "cidr_block" { type = string }
variable "az_count" { type = number, default = 2 }
variable "tags" { type = map(string), default = {} }
variable "enable_nat" { type = bool, default = true }
