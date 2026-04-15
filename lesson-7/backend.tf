# Backend configuration for Terraform state storage
# IMPORTANT:
# 1. First run:
#    terraform init
#    terraform apply -target=module.s3_backend
# 2. Then uncomment backend and run:
#    terraform init -migrate-state

terraform {
  backend "s3" {
    bucket         = "iryna-gychka-terraform-state-lesson-7"
    key            = "lesson-7/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks-lesson-7"
    encrypt        = true
  }
}