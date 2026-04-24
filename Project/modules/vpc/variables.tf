# Project name used for tagging resources
variable "project_name" {
  description = "Project name"
  type        = string
}

# Environment name used for tagging resources
variable "environment" {
  description = "Environment name"
  type        = string
}

# CIDR block for the main VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

# List of CIDR blocks for public subnets
variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)

  validation {
    condition     = length(var.public_subnets) > 0
    error_message = "At least one public subnet must be provided."
  }
}

# List of CIDR blocks for private subnets
variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)

  validation {
    condition     = length(var.private_subnets) > 0
    error_message = "At least one private subnet must be provided."
  }
}

# List of availability zones for subnet placement
variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) > 0
    error_message = "At least one availability zone must be provided."
  }
}

# Name tag for the VPC and related resources
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

# Name of the EKS cluster used for Kubernetes tagging
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}