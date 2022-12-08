locals {
  # default for cases when `null` value provided, meaning "use default"
  database_instance_class                = var.database_instance_class == null ? "db.t2.micro" : var.database_instance_class
  storage_type                           = var.storage_type == null ? "standard" : var.storage_type
  allocated_storage                      = var.allocated_storage == null ? 10 : var.allocated_storage
  database_version                       = var.database_version == null ? "" : var.database_version
  database_port                          = var.database_port == null ? "5432" : var.database_port
  snapshot_identifier                    = var.snapshot_identifier == null ? "" : var.snapshot_identifier
  backup_retention_period                = var.backup_retention_period == null ? 7 : var.backup_retention_period
  backup_window                          = var.backup_window == null ? "01:00-03:00" : var.backup_window
  maintenance_window                     = var.maintenance_window == null ? "mon:03:01-mon:05:00" : var.maintenance_window
  use_multiple_availability_zones        = var.use_multiple_availability_zones == null ? "no" : var.use_multiple_availability_zones
  use_encrypted_storage                  = var.use_encrypted_storage == null ? "no" : var.use_encrypted_storage
  allow_public_access                    = var.allow_public_access == null ? "no" : var.allow_public_access
  allow_major_version_upgrade            = var.allow_major_version_upgrade == null ? "no" : var.allow_major_version_upgrade
  enable_automatic_minor_version_upgrade = var.enable_automatic_minor_version_upgrade == null ? "yes" : var.enable_automatic_minor_version_upgrade
  enable_performance_insights            = var.enable_performance_insights == null ? "no" : var.enable_performance_insights
}
