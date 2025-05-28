variable "vpc_id" {
  description = "The ID of the VPC into which to deploy the database."
}

variable "subnet_ids" {
  description = "The IDs of the subnets to deploy the database into."
  type = list(string)
}
variable "allowed_cidrs" {
  description = "The CIDRs allowed access to the database."
  type = list(string)
}

variable "component" {
  description = "The component this database will serve."
}
variable "deployment_identifier" {
  description = "An identifier for this instantiation."
}

variable "database_instance_class" {
  description = "The instance type of the database instance."
  default     = "db.t4g.micro"
  nullable    = false
}
variable "storage_type" {
  description = "The storage type to use for the database instance. One of \"standard\" (magnetic), \"gp2\" (general purpose SSD), \"gp3\" (general purpose SSD that needs iops independently), \"io1\" or \"io2\" (provisioned IOPS SSD). The default is \"standard\"."
  default     = "standard"
  nullable    = false
}
variable "storage_iops" {
  description = "The amount of provisioned IOPS. Can only be set when `storage_type` is \"io1\" or \"gp3\"."
  type        = number
  default     = null
}
variable "allocated_storage" {
  description = "The allocated storage in GBs."
  type        = number
  default     = 10
  nullable    = false
}
variable "max_allocated_storage" {
  description = "When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to `allocated_storage`. Must be greater than or equal to `allocated_storage` or 0 to disable Storage Autoscaling."
  type        = number
  default     = null
}
variable "database_version" {
  description = "The database version. If omitted, it lets Amazon decide."
  default     = ""
  nullable    = false
}
variable "database_port" {
  description = "The port the database listens on. 5432 by default."
  default     = "5432"
  nullable    = false
}

variable "database_name" {
  description = "The name of the database schema to create. If omitted, no database schema is created initially."
}
variable "database_master_user_username" {
  description = "The username for the master database user."
}
variable "database_master_user_password" {
  description = "The password for the master database user. Either this variable or `database_master_user_password_wo` must be set."
  default = null
}
variable "database_master_user_password_wo" {
  description = "The password for the master database user, as a write-only variable. Either this variable or `database_master_user_password` must be set."
  default = null
}
variable "database_master_user_password_wo_version" {
  description = "The version of the write-only variable for the master database user password. This must be set if `database_master_user_password_wo` is set."
  default = null
}

variable "use_multiple_availability_zones" {
  description = "Whether or not to create a multi-availability zone database."
  type        = bool
  default     = false
  nullable    = false
}
variable "use_encrypted_storage" {
  description = "Whether or not to use encrypted storage for the database."
  type        = bool
  default     = false
  nullable    = false
}
variable "allow_public_access" {
  description = "Whether or not to allow public access to the database."
  type        = bool
  default     = false
  nullable    = false
}
variable "allow_major_version_upgrade" {
  description = "Whether or not major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible. Defaults to false."
  type        = bool
  default     = false
  nullable    = false
}
variable "enable_automatic_minor_version_upgrade" {
  description = "Whether or not minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true."
  type        = bool
  default     = true
  nullable    = false
}
variable "enable_performance_insights" {
  description = "Whether or not performance insights are enabled for the database. Defaults to false."
  type        = bool
  default     = false
  nullable    = false
}
variable "include_self_ingress_rule" {
  description = "Whether or not to allow access from the database security group to itself."
  type        = bool
  default     = false
  nullable    = false
}

variable "snapshot_identifier" {
  description = "The identifier of the snapshot to use to create the database."
  default     = ""
  nullable    = false
}

variable "backup_retention_period" {
  description = "The number of days to retain database backups."
  type        = number
  default     = 7
  nullable    = false
}
variable "backup_window" {
  description = "The time window in which backups should take place."
  default     = "01:00-03:00"
  nullable    = false
}
variable "maintenance_window" {
  description = "The time window in which maintenance should take place."
  default     = "mon:03:01-mon:05:00"
  nullable    = false
}
variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate or create."
  default     = null
}
variable "skip_final_snapshot" {
  description = "Whether or not to create a snapshot on deletion."
  type        = bool
  default     = true
  nullable    = false
}
