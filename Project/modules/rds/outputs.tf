output "db_endpoint" {
  value       = var.use_aurora ? aws_rds_cluster.this[0].endpoint : aws_db_instance.this[0].endpoint
  description = "Database endpoint"
}

output "db_port" {
  value       = var.port
  description = "Database port"
}

output "security_group_id" {
  value       = aws_security_group.this.id
  description = "Security group ID"
}

output "subnet_group_name" {
  value       = aws_db_subnet_group.this.name
  description = "DB subnet group name"
}

output "db_type" {
  value       = var.use_aurora ? "Aurora Cluster" : "RDS Instance"
  description = "Deployed database type"
}