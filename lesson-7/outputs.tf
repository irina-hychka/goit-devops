# VPC ID
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

# ECR repository URL
output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

# EKS cluster name
output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

# EKS cluster endpoint
output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

# S3 bucket name for Terraform state
output "s3_bucket_name" {
  description = "S3 bucket name for Terraform state"
  value       = module.s3_backend.bucket_name
}