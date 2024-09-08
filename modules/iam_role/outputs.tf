provider "aws" {
  region = "ap-northeast-1"
}

# IAMロールのARNを出力
output "role_arn" {
  description = "作成されたIAMロールのARN"
  value       = aws_iam_role.this.arn
}
