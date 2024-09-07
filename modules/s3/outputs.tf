# S3バケットのARN
output "bucket_arn" {
  description = "S3バケットのARN"
  value       = aws_s3_bucket.this.arn
}

# S3バケット名
output "bucket_name" {
  description = "S3バケットの名前"
  value       = aws_s3_bucket.this.bucket
}
