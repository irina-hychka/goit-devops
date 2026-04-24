variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

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

variable "kube_prometheus_stack_chart_version" {
  description = "kube-prometheus-stack Helm chart version"
  type        = string
  default     = "58.2.2"
}

variable "grafana_admin_user" {
  description = "Grafana admin username"
  type        = string
  default     = "admin"
}

variable "grafana_admin_password" {
  description = "Grafana admin password"
  type        = string
  sensitive   = true
  default     = "admin123"
}

variable "prometheus_retention" {
  description = "Prometheus metrics retention period"
  type        = string
  default     = "7d"
}