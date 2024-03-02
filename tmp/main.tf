#------------------------------------
# terraform configuretion
#------------------------------------
terraform {
  required_version = ">=0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}
#-------------------------------------
#Provider
#-------------------------------------

provider "aws" {
  #    profile = "terraform" # .aws\configに記載
  region = "ap-northeast-1"
}

#-------------------------------------
# varibales
#-------------------------------------
variable "project" {
  type = string
}
variable "enviroment" {
  type = string
}