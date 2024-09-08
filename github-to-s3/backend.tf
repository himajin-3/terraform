terraform {
  backend "s3" {
    bucket = "dev-tfstat-kamiguchi"
    key    = "github-to-s3"
    region = "ap-northeast-1"
    dynamodb_table = "tfstate-lock"
  }
}