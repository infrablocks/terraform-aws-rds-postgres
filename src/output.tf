output "postgres_database_host" {
  value = "${aws_db_instance.postgres_database.address}"
}

output "postgres_database_name" {
  value = "${aws_db_instance.postgres_database.name}"
}

output "postgres_database_port" {
  value = "5432"
}
