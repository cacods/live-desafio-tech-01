terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.85.0"
    }
  }

  backend "s3" {
    bucket = "live-devops-elite-backend"
    key    = "live-devops-elite.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {
  region = var.aws_region
}
