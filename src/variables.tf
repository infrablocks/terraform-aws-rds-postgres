variable "region" {
  default = "eu-west-2"
}

variable "private_network_cidr" {
  default = "10.0.0.0/8"
}

variable "component" {
}

variable "deployment_identifier" {
}

variable "database_instance_class" {
  default = "db.t2.micro"
}

variable "vpc_id" {
}

variable "private_subnet_ids" {
}

variable "database_name" {}
variable "database_master_user" {}
variable "database_master_user_password" {}
