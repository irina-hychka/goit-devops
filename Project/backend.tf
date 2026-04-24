terraform {
  backend "s3" {
    bucket         = "final-project-dev-terraform-state"
    key            = "final-project-dev/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "final-project-dev-terraform-locks"
    encrypt        = true
  }
}