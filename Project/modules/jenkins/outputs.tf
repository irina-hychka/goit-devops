output "jenkins_url_hint" {
  description = "Command to get Jenkins LoadBalancer hostname"
  value       = "kubectl get svc -n jenkins jenkins -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
}

output "jenkins_namespace" {
  description = "Jenkins namespace"
  value       = kubernetes_namespace.jenkins.metadata[0].name
}

output "jenkins_service_account" {
  description = "Jenkins Kubernetes service account"
  value       = kubernetes_service_account.jenkins.metadata[0].name
}

output "jenkins_iam_role_arn" {
  description = "Jenkins IAM role ARN"
  value       = aws_iam_role.jenkins.arn
}