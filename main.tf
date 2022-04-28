terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.11.0"
    }
    cloudflare = {
        source = "cloudflare/cloudflare"
        version = "~> 3.0"
    }
  }

  backend "s3" {
      bucket = "samroyio-website-backend"
      region = "us-east-1"
      key = "terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}