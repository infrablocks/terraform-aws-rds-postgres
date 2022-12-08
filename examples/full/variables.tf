variable "region" {}

variable "component" {}
variable "deployment_identifier" {}

variable "vpc_cidr" {}
variable "availability_zones" {
  type = list(string)
}

variable "private_zone_id" {}

variable "database_name" {}
variable "database_master_user" {}
variable "database_master_user_password" {}
