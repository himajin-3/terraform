# ロール名
variable "role_name" {
  description = "IAMロールの名前"
  type        = string
}

# ロールを引き受けるサービス (例: lambda.amazonaws.com, codepipeline.amazonaws.com)
variable "assume_role_services" {
  description = "このロールを引き受けることができるサービス"
  type        = list(string)
}

# 許可するアクション
variable "policy_actions" {
  description = "このロールに許可するアクション"
  type        = list(string)
}
