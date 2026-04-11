variable "ecr_name" {
  description = "Name of the ECR repository"
  type        = string

  # Validate repository name according to AWS naming rules
  validation {
    condition     = can(regex("^[a-z0-9._/-]{2,256}$", var.ecr_name))
    error_message = "ECR repository name must be 2–256 characters and contain only lowercase letters, numbers, hyphens, underscores, forward slashes, and periods."
  }
}

variable "scan_on_push" {
  description = "Enable automatic image scanning on push"
  type        = bool
  default     = true
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "MUTABLE"

  # Ensure only valid mutability values are allowed
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "Image tag mutability must be either MUTABLE or IMMUTABLE."
  }
}