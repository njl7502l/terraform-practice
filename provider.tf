terraform {
  required_version = ">= 1.2.6"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-for-njl7502l-terraform-practice"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
    profile = "hanazono"
  }
}

provider "aws" {
  region = "ap-northeast-1"
  profile = "hanazono"
}
