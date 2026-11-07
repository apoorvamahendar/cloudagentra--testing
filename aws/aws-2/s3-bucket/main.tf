resource "aws_s3_bucket" "bk26789" {
  bucket        = "bk26789"
  force_destroy = true

  tags = {
    Name  = "bk26789"
    Stack = "s3-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "bk26789_public_access" {
  bucket = aws_s3_bucket.bk26789.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bk26789_sse" {
  bucket = aws_s3_bucket.bk26789.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "bk26789_ownership" {
  bucket = aws_s3_bucket.bk26789.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}