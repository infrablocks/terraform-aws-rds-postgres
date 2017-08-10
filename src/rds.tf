resource "aws_db_instance" "postgres_database" {
  identifier              = "db-instance-${var.component}-${var.deployment_identifier}"
  allocated_storage       = 10
  storage_type            = "standard"
  engine                  = "postgres"
  engine_version          = "9.5.6"
  instance_class          = "${var.database_instance_class}"
  name                    = "${var.database_name}"
  username                = "${var.database_master_user}"
  password                = "${var.database_master_user_password}"
  snapshot_identifier     = "${var.snapshot_identifier}"
  publicly_accessible     = false
  multi_az                = false
  storage_encrypted       = false
  skip_final_snapshot     = true
  db_subnet_group_name    = "${aws_db_subnet_group.postgres_database_subnet_group.name}"
  vpc_security_group_ids  = [
    "${aws_security_group.postgres_database_security_group.id}"
  ]
  backup_retention_period = "${var.backup_retention_period}"
  backup_window = "${var.backup_window}"
  maintenance_window = "${var.maintenance_window}"
  tags {
    Name                  = "db-instance-${var.component}-${var.deployment_identifier}"
    Component             = "${var.component}"
    DeploymentIdentifier  = "${var.deployment_identifier}"
  }
}
