# 
provider "aws" {
  region = "ap-northeast-1"
}

# AWSアカウントIDを取得
data "aws_caller_identity" "current" {}