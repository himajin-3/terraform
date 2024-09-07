# IAMロールのARNを出力
output "role_arn" {
  description = "作成されたIAMロールのARN"
  value       = aws_iam_role.this.arn
}
