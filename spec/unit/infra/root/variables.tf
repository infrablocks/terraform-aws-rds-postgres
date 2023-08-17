variable "region" {}

variable "private_network_cidr" {}

variable "component" {}
variable "deployment_identifier" {}

variable "database_instance_class" {
  default = null
}
variable "database_version" {
  default = null
}
variable "database_port" {
  default = null
}

variable "storage_type" {
  default = null
}
variable "storage_iops" {
  default = null
}
variable "allocated_storage" {
  type    = number
  default = null
}
variable "max_allocated_storage" {
  type    = number
  default = null
}

variable "database_name" {}
variable "database_master_user" {}
variable "database_master_user_password" {}

variable "snapshot_identifier" {
  default = null
}
variable "backup_retention_period" {
  type    = number
  default = null
}
variable "backup_window" {
  default = null
}
variable "maintenance_window" {
  default = null
}
variable "parameter_group_name" {
  default = null
}
variable "use_multiple_availability_zones" {
  default = null
}
variable "use_encrypted_storage" {
  default = null
}
variable "allow_public_access" {
  default = null
}
variable "allow_major_version_upgrade" {
  default = null
}
variable "enable_automatic_minor_version_upgrade" {
  default = null
}
variable "enable_performance_insights" {
  default = null
}
variable "include_self_ingress_rule" {
  default = null
}
