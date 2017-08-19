output "vpc_id" {
  value = "${module.base_network.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.base_network.vpc_cidr}"
}

output "public_subnet_ids" {
  value = "${module.base_network.public_subnet_ids}"
}

output "private_subnet_ids" {
  value = "${module.base_network.private_subnet_ids}"
}

output "postgres_database_host" {
  value = "${module.rds_postgres.postgres_database_host}"
}
output "postgres_database_port" {
  value = "${module.rds_postgres.postgres_database_port}"
}

output "postgres_database_name" {
  value = "${module.rds_postgres.postgres_database_name}"
}
