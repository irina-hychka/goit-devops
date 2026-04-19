# Name of the EKS cluster
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "lesson-8-9-eks"
}

# Kubernetes version for the EKS cluster
variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.29"
}

# ID of the VPC where the EKS cluster will be deployed
variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

# List of subnet IDs used by the EKS cluster
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) > 0
    error_message = "At least one subnet ID must be provided for the EKS cluster."
  }
}

# List of private subnet IDs used by the EKS node group
variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EKS node group"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) > 0
    error_message = "At least one private subnet ID must be provided for the EKS node group."
  }
}

# EC2 instance types for the EKS worker nodes
variable "instance_types" {
  description = "List of EC2 instance types for the EKS node group"
  type        = list(string)
  default     = ["t3.medium"]

  validation {
    condition     = length(var.instance_types) > 0
    error_message = "At least one instance type must be provided."
  }
}

# Desired number of worker nodes
variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

# Minimum number of worker nodes
variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

# Maximum number of worker nodes
variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}