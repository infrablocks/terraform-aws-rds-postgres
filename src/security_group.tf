resource "aws_security_group" "postgres_database_security_group" {
  name                   = "database-security-group-${var.component}-${var.deployment_identifier}"
  description            = "Allow access to ${var.component} PostgreSQL database from private network."
  vpc_id                 = "${var.vpc_id}"
  tags {
    Name                 = "sg-database-${var.component}-${var.deployment_identifier}"
    Component            = "${var.component}"
    DeploymentIdentifier = "${var.deployment_identifier}"
  }
  ingress {
    from_port            = 5432
    to_port              = 5432
    protocol             = "tcp"
    cidr_blocks          = [
      "${var.private_network_cidr}"
    ]
  }
}