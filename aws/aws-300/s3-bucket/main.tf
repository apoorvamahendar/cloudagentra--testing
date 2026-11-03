resource "aws_s3_bucket" "cloudagentra_storage_bucket_293887" {
  bucket        = "cloudagentra-storage-bucket-293887"
  force_destroy = true
  tags = {
    Name  = "cloudagentra-storage-bucket-293887"
    Stack = "s3-bucket"
  }
}

resource "aws_s3_bucket_versioning" "cloudagentra_storage_bucket_versioning" {
  bucket = aws_s3_bucket.cloudagentra_storage_bucket_293887.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "cloudagentra_storage_bucket_access_block" {
  bucket                  = aws_s3_bucket.cloudagentra_storage_bucket_293887.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "bucket_209392" {
  bucket        = "bucket-209392"
  force_destroy = true
  tags = {
    Name  = "bucket-209392"
    Stack = "s3-bucket"
  }
}

resource "aws_s3_bucket_versioning" "bucket_209392_versioning" {
  bucket = aws_s3_bucket.bucket_209392.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_209392_access_block" {
  bucket                  = aws_s3_bucket.bucket_209392.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "cloudagentra_storage_bucket_293887_id" {
  value = aws_s3_bucket.cloudagentra_storage_bucket_293887.id
}

output "cloudagentra_storage_bucket_293887_arn" {
  value = aws_s3_bucket.cloudagentra_storage_bucket_293887.arn
}

output "bucket_209392_id" {
  value = aws_s3_bucket.bucket_209392.id
}

output "bucket_209392_arn" {
  value = aws_s3_bucket.bucket_209392.arn
}