resource "aws_s3_bucket" "terraform_state" {
  # S3 bucket name is passed from the module input variable
  bucket = var.bucket_name

  # Prevent accidental deletion of the Terraform state bucket
  lifecycle {
    prevent_destroy = true
  }

  # Tags for resource identification and management
  tags = {
    Name        = var.bucket_name
    Purpose     = "Terraform State Storage"
    ManagedBy   = "Terraform"
    Environment = "shared"
  }
}

# Enable versioning to keep history of state files
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable default server-side encryption (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block all forms of public access to the bucket
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}