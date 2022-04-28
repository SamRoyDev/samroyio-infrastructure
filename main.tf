terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.44.0"
    }
  }

  backend "s3" {
      bucket = "samroyio-website-backend"
      region = "us-east-1"
      key = "/"
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "website-bucket" {
    bucket = var.website-bucket
    force_destroy = true
    versioning {
        enabled = true
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}