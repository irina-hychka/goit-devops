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

# OIDC issuer URL (needed for IRSA and integrations)
output "cluster_oidc_issuer" {
  description = "OIDC issuer URL for the EKS cluster"
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

# OIDC provider ARN for EKS.
# Used for IRSA to give pods access to AWS (e.g., Jenkins → ECR)
output "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider"
  value       = aws_iam_openid_connect_provider.eks.arn
}