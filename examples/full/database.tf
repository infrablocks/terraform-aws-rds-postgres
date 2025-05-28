module "rds_postgres" {
  source = "./../../"

  component             = var.component
  deployment_identifier = var.deployment_identifier

  vpc_id     = module.base_network.vpc_id
  subnet_ids = module.base_network.private_subnet_ids

  allowed_cidrs = [module.base_network.vpc_cidr]

  database_instance_class = "db.t4g.small"
  database_version        = "17.5"

  database_name                 = var.database_name
  database_master_user_username = var.database_master_user_username
  database_master_user_password = var.database_master_user_password

  enable_performance_insights = true
  include_self_ingress_rule   = true
}
