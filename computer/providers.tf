locals {
  aws_id      = "058264236297"
  name_prefix = "terraform"
  region      = "ap-northeast-1"
  Environment = "dev"
}
 
terraform {
  required_version = "~> 1.8.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.64.0"
    }
  }
}
