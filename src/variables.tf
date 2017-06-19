variable "region" {
  default = "eu-west-2"
}

variable "private_network_cidr" {
  default = "10.0.0.0/8"
}

variable "component" {
  default = "payment-service"
}

variable "deployment_identifier" {
  default = "default"
}

variable "database_instance_class" {
  default = "db.t2.micro"
}

variable "vpc_id" {
  default = ""
}

variable "private_subnet_ids" {
  default = ""
}

variable "database_name" {}
variable "database_master_user" {}
variable "database_master_user_password" {}
variable "state_bucket" {}
variable "state_network_key" {}
