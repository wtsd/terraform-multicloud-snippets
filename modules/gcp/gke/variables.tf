variable "name" { type = string }
variable "project" { type = string }
variable "region" { type = string }
variable "network" { type = string }
variable "subnetwork" { type = string }
variable "min_nodes" { type = number, default = 1 }
variable "max_nodes" { type = number, default = 2 }
