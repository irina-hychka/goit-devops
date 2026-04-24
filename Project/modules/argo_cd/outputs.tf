output "argocd_namespace" {
  description = "Argo CD namespace"
  value       = kubernetes_namespace.argocd.metadata[0].name
}

output "argocd_application_name" {
  description = "Argo CD application name"
  value       = var.app_name
}

output "argocd_server_hint" {
  description = "Command to get Argo CD LoadBalancer hostname"
  value       = "kubectl get svc -n argocd argocd-server -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
}

output "argocd_admin_password_hint" {
  description = "Command to get Argo CD initial admin password"
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 --decode"
}