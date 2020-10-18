data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "rds_postgres" {
  source = "../../../../"

  component = var.component
  deployment_identifier = var.deployment_identifier

  vpc_id = data.terraform_remote_state.prerequisites.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.prerequisites.outputs.private_subnet_ids

  private_network_cidr = var.private_network_cidr

  database_instance_class = var.database_instance_class
  database_version = "9.5.6"

  database_name = var.database_name
  database_master_user_password = var.database_master_user_password
  database_master_user = var.database_master_user

  snapshot_identifier = var.snapshot_identifier
  backup_retention_period = var.backup_retention_period
  backup_window = var.backup_window
  maintenance_window = var.maintenance_window

  include_self_ingress_rule = var.include_self_ingress_rule
}

