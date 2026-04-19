# Name of the S3 bucket for Terraform state
variable "bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}

# Name of the DynamoDB table for state locking
variable "dynamodb_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
}