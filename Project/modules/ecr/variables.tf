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

# Name of the ECR repository
variable "ecr_name" {
  description = "Name of the ECR repository"
  type        = string
}

# Enable or disable image scanning on push
variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

# Define whether image tags are mutable or immutable
variable "image_tag_mutability" {
  description = "Image tag mutability setting (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "MUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be either MUTABLE or IMMUTABLE."
  }
}

# Allow force delete of repository (useful for dev environments)
variable "force_delete" {
  description = "Force delete repository even if it contains images"
  type        = bool
  default     = true
}