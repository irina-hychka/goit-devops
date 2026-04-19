resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = "jenkins"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_role" "jenkins" {
  name = "jenkins-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${replace(var.oidc_provider_url, "https://", "")}:aud" = "sts.amazonaws.com"
          "${replace(var.oidc_provider_url, "https://", "")}:sub" = "system:serviceaccount:jenkins:jenkins"
        }
      }
    }]
  })

  tags = {
    Name      = "jenkins-eks-role"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role_policy" "jenkins_ecr" {
  name = "jenkins-ecr-policy"
  role = aws_iam_role.jenkins.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "kubernetes_service_account" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = kubernetes_namespace.jenkins.metadata[0].name

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.jenkins.arn
    }
  }
}

resource "helm_release" "jenkins" {
  name             = "jenkins"
  repository       = "https://charts.jenkins.io"
  chart            = "jenkins"
  version          = "5.1.5"
  namespace        = kubernetes_namespace.jenkins.metadata[0].name
  create_namespace = false
  timeout          = 600

  values = [templatefile("${path.module}/values.yaml", {
    ecr_repo_url    = var.ecr_repo_url
    aws_region      = var.aws_region
    github_repo_url = var.github_repo_url
    aws_account_id  = data.aws_caller_identity.current.account_id
    service_account = kubernetes_service_account.jenkins.metadata[0].name
  })]

  depends_on = [
    kubernetes_namespace.jenkins,
    kubernetes_service_account.jenkins,
    aws_iam_role_policy.jenkins_ecr
  ]
}