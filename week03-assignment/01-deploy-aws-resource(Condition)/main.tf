variable "bucket_name" {
  type        = string
  description = "Type bucket name you want"
}

resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  count  = length(var.bucket_name) > 5 ? 1 : 0

  tags = {
    Name = "Sample S3 Bucket"
  }
}