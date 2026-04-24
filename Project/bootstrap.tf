module "s3_backend" {
  source = "./modules/s3-backend"

  project_name        = var.project_name
  environment         = var.environment
  bucket_name         = "final-project-dev-terraform-state"
  dynamodb_table_name = "final-project-dev-terraform-locks"
}