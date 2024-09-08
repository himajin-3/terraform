terraform {
  backend "s3" {
    bucket = "dev-tfstat-kamiguchi"
    key    = "study"
    region = "ap-northeast-1"
    dynamodb_table = "tfstate-lock"
  }
}