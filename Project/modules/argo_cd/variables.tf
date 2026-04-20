variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "Base64 encoded EKS cluster CA certificate"
  type        = string
}

variable "argocd_chart_version" {
  description = "Argo CD Helm chart version"
  type        = string
  default     = "5.51.6"
}

variable "github_repo_url" {
  description = "GitHub repository URL with Helm chart or manifests"
  type        = string
}

variable "target_revision" {
  description = "Git revision for Argo CD application"
  type        = string
  default     = "lesson-db-module"
}

variable "app_name" {
  description = "Argo CD application name"
  type        = string
  default     = "django-app"
}

variable "app_namespace" {
  description = "Namespace where the application will be deployed"
  type        = string
  default     = "django-app"
}

variable "app_chart_path" {
  description = "Path to the Helm chart in the Git repository"
  type        = string
  default     = "charts/django-app"
}