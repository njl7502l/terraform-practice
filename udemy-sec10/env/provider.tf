terraform {
  required_version = ">= 1.2.6"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
  backend "s3" {
    bucket = "njl7502l-terraform-practice-udemy-sec10-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
    profile = "hanazono_terraform_deployer"
  }
}

provider "aws" {
  region = "ap-northeast-1"
  profile = "hanazono_terraform_deployer"
}
