resource "aws_dynamodb_table" "terraform_locks" {
  # DynamoDB table name is passed from the module input variable
  name         = var.table_name

  # Use on-demand billing (no need to manage capacity)
  billing_mode = "PAY_PER_REQUEST"

  # Primary key used by Terraform for state locking
  hash_key     = "LockID"

  # Define the primary key attribute
  attribute {
    name = "LockID"
    type = "S"
  }

  # Enable point-in-time recovery for data protection
  point_in_time_recovery {
    enabled = true
  }

  # Tags for resource identification and management
  tags = {
    Name        = var.table_name
    Purpose     = "Terraform State Locking"
    ManagedBy   = "Terraform"
    Environment = "shared"
  }
}