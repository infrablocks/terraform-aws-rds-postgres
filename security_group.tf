resource "aws_security_group" "postgres_database_security_group" {
  name_prefix = "database-security-group-${var.component}-${var.deployment_identifier}-"
  description = "Default security group for ${var.component} PostgreSQL database instance with deployment identifier ${var.deployment_identifier} allowing access from provided CIDRs."
  vpc_id      = var.vpc_id

  tags = {
    Name                 = "sg-database-${var.component}-${var.deployment_identifier}"
    Component            = var.component
    DeploymentIdentifier = var.deployment_identifier
  }

  ingress {
    from_port = var.database_port
    to_port   = var.database_port
    protocol  = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  dynamic "ingress" {
    for_each = var.include_self_ingress_rule ? [1] : []
    content {
      self      = true
      from_port = 0
      to_port   = 65535
      protocol  = "tcp"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}
