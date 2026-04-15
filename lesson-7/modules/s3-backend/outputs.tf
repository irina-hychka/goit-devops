# Name of the S3 bucket
output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.terraform_state.id
}

# Name of the DynamoDB table
output "dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = aws_dynamodb_table.terraform_locks.name
}