output "postgres_ip" {
  value = aws_instance.postgres.public_ip
}

output "postgres_private_ip" {
  value = aws_instance.postgres.private_ip
}

output "database_url" {
  value = "postgres://${var.db_user}:${var.db_pass}@${aws_instance.postgres.private_ip}:5432/${var.db_name}"
}