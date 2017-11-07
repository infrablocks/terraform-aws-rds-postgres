variable "region" {}
variable "vpc_cidr" {}
variable "availability_zones" {}
variable "private_network_cidr" {}

variable "component" {}
variable "deployment_identifier" {}

variable "private_zone_id" {}

variable "database_instance_class" {}

variable "database_name" {}
variable "database_master_user" {}
variable "database_master_user_password" {}

variable "infrastructure_events_bucket" {}
variable "snapshot_identifier" {}
variable "backup_retention_period" {}
variable "backup_window" {}
variable "maintenance_window" {}
