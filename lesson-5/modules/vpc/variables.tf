variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  # Validate that the value is a valid IPv4 CIDR block
  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "The VPC CIDR block must be a valid IPv4 CIDR."
  }
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets (one per availability zone)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  # Ensure the number of subnets matches the number of AZs
  validation {
    condition     = length(var.public_subnets) == length(var.availability_zones)
    error_message = "Number of public subnets must match number of availability zones."
  }
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets (one per availability zone)"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  # Ensure the number of subnets matches the number of AZs
  validation {
    condition     = length(var.private_subnets) == length(var.availability_zones)
    error_message = "Number of private subnets must match number of availability zones."
  }
}

variable "availability_zones" {
  description = "List of availability zones for subnet placement"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vpc_name" {
  description = "Name prefix for all VPC-related resources"
  type        = string
  default     = "lesson-5-vpc"
}