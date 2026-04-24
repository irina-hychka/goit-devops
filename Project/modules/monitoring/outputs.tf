output "monitoring_namespace" {
  description = "Monitoring namespace"
  value       = kubernetes_namespace.monitoring.metadata[0].name
}

output "grafana_url_hint" {
  description = "Command to get Grafana LoadBalancer hostname"
  value       = "kubectl get svc -n monitoring monitoring-grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
}

output "grafana_admin_user" {
  description = "Grafana admin username"
  value       = var.grafana_admin_user
}

output "grafana_admin_password_hint" {
  description = "Grafana admin password source"
  value       = "Password is set from var.grafana_admin_password"
}