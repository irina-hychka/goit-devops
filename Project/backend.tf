terraform {
  backend "s3" {
    bucket         = "lesson-8-9-terraform-state"
    key            = "lesson-8-9/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "lesson-8-9-terraform-locks"
    encrypt        = true
  }
}