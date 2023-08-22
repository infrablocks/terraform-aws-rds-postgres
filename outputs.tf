output "postgres_database_host" {
  description = "The database host."
  value = aws_db_instance.postgres_database.address
}

output "postgres_database_name" {
  description = "The database name."
  value = aws_db_instance.postgres_database.db_name
}

output "postgres_database_port" {
  description = "The database port."
  value = "5432"
}

output "postgres_database_sg_id" {
  description = "The security group ID associated with the database."
  value = aws_security_group.postgres_database_security_group.id
}

output "postgres_database_sg_name" {
  description = "The security group name associated with the database."
  value = aws_security_group.postgres_database_security_group.name
}
