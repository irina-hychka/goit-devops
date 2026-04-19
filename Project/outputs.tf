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