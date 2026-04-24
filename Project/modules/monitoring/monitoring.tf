resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"

    labels = {
      app         = "monitoring"
      project     = var.project_name
      environment = var.environment
      managed-by  = "terraform"
    }
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name             = "monitoring"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = var.kube_prometheus_stack_chart_version
  namespace        = kubernetes_namespace.monitoring.metadata[0].name
  create_namespace = false
  timeout          = 600

  values = [
    yamlencode({
      grafana = {
        enabled       = true
        adminUser     = var.grafana_admin_user
        adminPassword = var.grafana_admin_password

        service = {
          type = "LoadBalancer"
        }
      }

      prometheus = {
        enabled = true

        prometheusSpec = {
          retention = var.prometheus_retention

          resources = {
            requests = {
              cpu    = "100m"
              memory = "256Mi"
            }
            limits = {
              cpu    = "500m"
              memory = "1Gi"
            }
          }
        }
      }

      alertmanager = {
        enabled = true
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}