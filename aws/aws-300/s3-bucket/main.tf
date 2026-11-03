resource "aws_s3_bucket" "bucket_293887" {
  bucket        = "cloudagentra-storage-bucket-293887"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "bucket_293887_access_block" {
  bucket                  = aws_s3_bucket.bucket_293887.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "bucket_293887_versioning" {
  bucket = aws_s3_bucket.bucket_293887.id
  versioning_configuration {
    status = "Enabled"
  }
}