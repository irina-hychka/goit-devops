output "repository_url" {
  description = "URL of the ECR repository for pushing and pulling Docker images"
  value       = aws_ecr_repository.main.repository_url
}

output "repository_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.main.arn
}

output "registry_id" {
  description = "AWS account ID (registry ID) where the repository is created"
  value       = aws_ecr_repository.main.registry_id
}

output "repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.main.name
}