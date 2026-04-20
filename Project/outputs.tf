output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "jenkins_url_hint" {
  description = "Command to get Jenkins LoadBalancer hostname"
  value       = module.jenkins.jenkins_url_hint
}

output "argocd_server_hint" {
  description = "Command to get Argo CD LoadBalancer hostname"
  value       = module.argo_cd.argocd_server_hint
}

output "argocd_admin_password_hint" {
  description = "Command to get Argo CD initial admin password"
  value       = module.argo_cd.argocd_admin_password_hint
}

output "rds_postgres_endpoint" {
  value       = module.rds_postgres.db_endpoint
  description = "RDS PostgreSQL endpoint"
}

output "rds_postgres_port" {
  value       = module.rds_postgres.db_port
  description = "RDS PostgreSQL port"
}

output "rds_postgres_type" {
  value       = module.rds_postgres.db_type
  description = "RDS PostgreSQL type"
}

output "rds_aurora_endpoint" {
  value       = module.rds_aurora.db_endpoint
  description = "Aurora cluster endpoint"
}

output "rds_aurora_port" {
  value       = module.rds_aurora.db_port
  description = "Aurora cluster port"
}

output "rds_aurora_type" {
  value       = module.rds_aurora.db_type
  description = "Aurora database type"
}