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
}