# ID of the created VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# List of public subnet IDs
output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

# List of private subnet IDs
output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.private[*].id
}

# Optional but useful (for future modules)
output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}