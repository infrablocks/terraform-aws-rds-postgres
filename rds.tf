resource "aws_db_instance" "postgres_database" {
  identifier = "db-instance-${var.component}-${var.deployment_identifier}"

  engine         = "postgres"
  engine_version = var.database_version

  instance_class = var.database_instance_class

  publicly_accessible = var.allow_public_access == "yes" ? true : false
  multi_az            = var.use_multiple_availability_zones == "yes" ? true : false

  port = var.database_port

  db_subnet_group_name = aws_db_subnet_group.postgres_database_subnet_group.name

  vpc_security_group_ids = [
    aws_security_group.postgres_database_security_group.id
  ]

  storage_type          = var.storage_type
  iops                  = var.storage_iops
  storage_encrypted     = var.use_encrypted_storage == "yes" ? true : false
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  db_name  = var.database_name
  username = var.database_master_user
  password = var.database_master_user_password

  snapshot_identifier = var.snapshot_identifier
  skip_final_snapshot = var.skip_final_snapshot
  final_snapshot_identifier = "db-instance-${var.component}-${var.deployment_identifier}"

  performance_insights_enabled = var.enable_performance_insights == "yes" ? true : false
  allow_major_version_upgrade  = var.allow_major_version_upgrade == "yes" ? true : false
  auto_minor_version_upgrade   = var.enable_automatic_minor_version_upgrade == "yes" ? true : false

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  parameter_group_name    = var.parameter_group_name

  tags = {
    Name                 = "db-instance-${var.component}-${var.deployment_identifier}"
    Component            = var.component
    DeploymentIdentifier = var.deployment_identifier
  }
}
