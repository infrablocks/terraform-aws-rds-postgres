output "postgres_database_host" {
  description = "The database host."
  value       = aws_db_instance.postgres_database.address
}

output "postgres_database_name" {
  description = "The database name."
  value       = aws_db_instance.postgres_database.name
}

output "postgres_database_port" {
  description = "The database port."
  value       = "5432"
}
