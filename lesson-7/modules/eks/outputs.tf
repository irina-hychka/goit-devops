# Name of the EKS cluster
output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.main.name
}

# Endpoint for the EKS cluster API server
output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.main.endpoint
}

# Base64 encoded certificate data required to authenticate with the cluster
output "cluster_ca_certificate" {
  description = "EKS cluster CA certificate"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}