variable "region" {}
variable "private_network_cidr" {}

variable "component" {}
variable "deployment_identifier" {}

variable "database_instance_class" {}

variable "database_name" {}
variable "database_master_user" {}
variable "database_master_user_password" {}

variable "snapshot_identifier" {}
variable "backup_retention_period" {}
variable "backup_window" {}
variable "maintenance_window" {}

variable "include_self_ingress_rule" {}

variable "allow_major_version_upgrade" {}
variable "auto_minor_version_upgrade" {}
variable "storage_type" {}

variable "performance_insights_enabled" {}