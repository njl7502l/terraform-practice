terraform {
  required_version = ">= 1.2.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
  backend "s3" {
    bucket  = "tf-practice-test-tfstate"
    key     = "terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "hanazono_terraform_deployer"
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "hanazono_terraform_deployer"
}
