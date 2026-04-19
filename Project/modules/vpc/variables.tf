# CIDR block for the main VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
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
  default     = "lesson-8-9-vpc"
}

# Name of the EKS cluster used for Kubernetes tagging
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "lesson-8-9-eks"
}