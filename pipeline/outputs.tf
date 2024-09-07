
# アカウントID取得
data "aws_caller_identity" "current" {}
data "aws_caller_identity" "self" {}

output "account_id" {
  value = "${data.aws_caller_identity.self.account_id}"
}


# Lambda
output "lambda_role_arn" {
  description = "Lambda IAMロールのARN"
  value       = module.lambda_iam_role.role_arn
}

# codepipeline
output "codepipeline_role_arn" {
  description = "CodePipeline IAMロールのARN"
  value       = module.codepipeline_iam_role.role_arn
}