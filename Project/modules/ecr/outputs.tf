# URL of the ECR repository (used for pushing and pulling images)
output "repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.main.repository_url
}

# Name of the ECR repository
output "repository_name" {
  description = "ECR repository name"
  value       = aws_ecr_repository.main.name
}

# Useful for CI/CD (account ID)
output "registry_id" {
  description = "AWS account ID (ECR registry ID)"
  value       = aws_ecr_repository.main.registry_id
}