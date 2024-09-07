terraform {
  backend "s3" {
    bucket = "dev-tfstat-kamiguchi"
    key    = "pipeline"
    region = "ap-northeast-1"
    dynamodb_table = "tfstate-lock"
  }
}