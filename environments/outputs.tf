# リージョン取得
output "aws_region" {
  description = "現在のAWSリージョン"
  value       = provider.aws.region
}

# アカウントIDを出力
output "account_id" {
  description = "AWSアカウントID"
  value       = data.aws_caller_identity.current.account_id
}
