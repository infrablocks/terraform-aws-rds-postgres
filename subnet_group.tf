resource "aws_db_subnet_group" "postgres_database_subnet_group" {
  name        = "${var.component}-${var.deployment_identifier}"
  description = "Subnet group for ${var.component} PostgreSQL database instance with deployment identifier ${var.deployment_identifier}."
  subnet_ids  = var.subnet_ids

  tags = {
    Name                 = "db-subnet-group-${var.component}-${var.deployment_identifier}"
    Component            = var.component
    DeploymentIdentifier = var.deployment_identifier
  }
}
