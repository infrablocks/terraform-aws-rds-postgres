variable "vpc_id" {
  description = "The ID of the VPC into which to deploy the database."
}
variable "private_subnet_ids" {
  description = "The IDs of the private subnets to deploy the database into."
  type        = list(string)
}
variable "private_network_cidr" {
  description = "The CIDR of the private network allowed access to the database."
}

variable "component" {
  description = "The component this database will serve."
}
variable "deployment_identifier" {
  description = "An identifier for this instantiation."
}

variable "database_instance_class" {
  description = "The instance type of the database instance."
  default     = "db.t2.micro"
}
variable "allocated_storage" {
  description = "The allocated storage in GBs."
  default     = 10
}
variable "max_allocated_storage" {
  description = "When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance. See the terraform documentation for more information."
  default     = 0
}
variable "database_version" {
  description = "The database version. If omitted, it lets Amazon decide."
  default     = ""
}

variable "database_name" {
  description = "The name of the database schema to create. If omitted, no database schema is created initially."
}
variable "database_master_user" {
  description = "The password for the master database user."
}
variable "database_master_user_password" {
  description = "The username for the master database user."
}

variable "use_multiple_availability_zones" {
  description = "Whether or not to create a multi-availability zone database (\"yes\" or \"no\")."
  default     = "no"
}
variable "use_encrypted_storage" {
  description = "Whether or not to use encrypted storage for the database (\"yes\" or \"no\")."
  default     = "no"
}

variable "snapshot_identifier" {
  description = "The identifier of the snapshot to use to create the database."
  default     = ""
}

variable "backup_retention_period" {
  description = "The number of days to retain database backups."
  default     = 7
}
variable "backup_window" {
  description = "The time window in which backups should take place."
  default     = "01:00-03:00"
}
variable "maintenance_window" {
  description = "The time window in which maintenance should take place."
  default     = "mon:03:01-mon:05:00"
}

variable "include_self_ingress_rule" {
  description = "Whether or not to allow access from the database security group to itself (\"yes\" or \"no\")."
  default     = "no"
}

variable "allow_major_version_upgrade" {
  description = "Whether or not to allow major version upgrades (\"yes\" or \"no\")."
  default = "no"
}

variable "auto_minor_version_upgrade" {
  description = "Whether or not to enable auto minor version upgrades (\"yes\" or \"no\")."
  default = "yes"
}

variable "storage_type" {
  description = "The type of storage to use, either \"standard\" (magnetic) or \"gp2\" (general purpose SSD)."
  default = "standard"

  validation {
    condition     = contains(["standard", "gp2"], var.storage_type)
    error_message = "Must be one of standard or gp2. Provisioned IOPS (io1) not yet supported."
  }
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled. Defaults to false."
  default = "no"
}
