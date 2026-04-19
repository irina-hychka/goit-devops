output "jenkins_url_hint" {
  description = "Command to get Jenkins LoadBalancer hostname"
  value       = "kubectl get svc -n jenkins jenkins -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
}