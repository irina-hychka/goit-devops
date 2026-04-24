locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

module "vpc" {
  source = "./modules/vpc"

  project_name       = var.project_name
  environment        = var.environment
  vpc_name           = "${local.name_prefix}-vpc"
  cluster_name       = "${local.name_prefix}-eks"
  vpc_cidr_block     = var.vpc_cidr_block
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  environment  = var.environment
  ecr_name     = "${local.name_prefix}-django-app"
}

module "eks" {
  source = "./modules/eks"

  project_name       = var.project_name
  environment        = var.environment
  cluster_name       = "${local.name_prefix}-eks"
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

  project_name           = var.project_name
  environment            = var.environment
  cluster_name           = module.eks.cluster_name
  cluster_endpoint       = module.eks.cluster_endpoint
  cluster_ca_certificate = module.eks.cluster_ca_certificate
  ecr_repo_url           = module.ecr.repository_url
  aws_region             = var.aws_region
  github_repo_url        = var.github_repo_url
  github_branch          = var.github_branch
  oidc_provider_arn      = module.eks.oidc_provider_arn
  oidc_provider_url      = module.eks.cluster_oidc_issuer
}

module "argo_cd" {
  source = "./modules/argo_cd"

  project_name           = var.project_name
  environment            = var.environment
  cluster_name           = module.eks.cluster_name
  cluster_endpoint       = module.eks.cluster_endpoint
  cluster_ca_certificate = module.eks.cluster_ca_certificate

  github_repo_url      = var.github_repo_url
  target_revision      = var.github_branch
  app_name             = "django-app"
  app_namespace        = "django-app"
  app_chart_path       = "charts/django-app"
  argocd_chart_version = "5.51.6"
}

module "monitoring" {
  source = "./modules/monitoring"

  project_name           = var.project_name
  environment            = var.environment
  cluster_name           = module.eks.cluster_name
  cluster_endpoint       = module.eks.cluster_endpoint
  cluster_ca_certificate = module.eks.cluster_ca_certificate
}

module "rds_postgres" {
  source = "./modules/rds"

  project_name   = var.project_name
  environment    = var.environment
  identifier     = "${local.name_prefix}-postgres"
  use_aurora     = false
  engine         = "postgres"
  engine_version = "15.10"
  instance_class = "db.t3.micro"

  db_name  = "appdb"
  username = "dbadmin"
  password = "SuperSecret123!"

  multi_az            = false
  subnet_ids          = module.vpc.private_subnet_ids
  vpc_id              = module.vpc.vpc_id
  allowed_cidr_blocks = [module.vpc.vpc_cidr_block]
}