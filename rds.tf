resource "aws_db_instance" "postgres_database" {
  identifier            = "db-instance-${var.component}-${var.deployment_identifier}"
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  engine                = "postgres"
  engine_version        = var.database_version
  instance_class        = var.database_instance_class
  name                  = var.database_name
  username              = var.database_master_user
  password              = var.database_master_user_password
  snapshot_identifier   = var.snapshot_identifier
  publicly_accessible   = false
  multi_az              = var.use_multiple_availability_zones == "yes" ? true : false
  storage_encrypted     = var.use_encrypted_storage == "yes" ? true : false
  skip_final_snapshot   = true
  db_subnet_group_name  = aws_db_subnet_group.postgres_database_subnet_group.name
  allow_major_version_upgrade = var.allow_major_version_upgrade == "yes" ? true : false
  auto_minor_version_upgrade = var.auto_minor_version_upgrade == "yes" ? true : false
  performance_insights_enabled = var.performance_insights_enabled == "yes" ? true : false

  vpc_security_group_ids = [
    aws_security_group.postgres_database_security_group.id
  ]

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  tags = {
    Name                 = "db-instance-${var.component}-${var.deployment_identifier}"
    Component            = var.component
    DeploymentIdentifier = var.deployment_identifier
  }
}
