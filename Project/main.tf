module "vpc" {
  source = "./modules/vpc"

  vpc_name           = "lesson-8-9-vpc"
  cluster_name       = "lesson-8-9-eks"
  vpc_cidr_block     = var.vpc_cidr_block
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "ecr" {
  source = "./modules/ecr"

  ecr_name = "lesson-8-9-django-app"
}

module "eks" {
  source = "./modules/eks"

  cluster_name       = "lesson-8-9-eks"
  cluster_version    = var.cluster_version
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_types     = var.instance_types
  desired_size       = var.desired_size
  min_size           = var.min_size
  max_size           = var.max_size
}

module "jenkins" {
  source = "./modules/jenkins"

  cluster_name           = module.eks.cluster_name
  cluster_endpoint       = module.eks.cluster_endpoint
  cluster_ca_certificate = module.eks.cluster_ca_certificate
  ecr_repo_url           = module.ecr.repository_url
  aws_region             = var.aws_region
  github_repo_url        = var.github_repo_url
  oidc_provider_arn      = module.eks.oidc_provider_arn
  oidc_provider_url      = module.eks.cluster_oidc_issuer

}

module "argo_cd" {
  source = "./modules/argo_cd"

  cluster_name           = module.eks.cluster_name
  cluster_endpoint       = module.eks.cluster_endpoint
  cluster_ca_certificate = module.eks.cluster_ca_certificate

  github_repo_url      = var.github_repo_url
  target_revision      = "lesson-db-module"
  app_name             = "django-app"
  app_namespace        = "django-app"
  app_chart_path       = "Project/charts/django-app"
  argocd_chart_version = "5.51.6"
}