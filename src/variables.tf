variable "region" {
  default = "eu-west-2"
}

variable "private_network_cidr" {}

variable "component" {}

variable "deployment_identifier" {}

variable "database_instance_class" {
  default = "db.t2.micro"
}

variable "vpc_id" {}

variable "private_subnet_ids" {}

variable "database_name" {}
variable "database_master_user" {}
variable "database_master_user_password" {}
variable "snapshot_identifier" {
  default = ""
}
variable backup_retention_period {
  default = 7
}

variable backup_window {
  default = "01:00-03:00"
}

variable maintenance_window {
  default = "mon:03:01-mon:05:00"
}
