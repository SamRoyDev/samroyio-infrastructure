terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.44.0"
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

resource "aws_s3_bucket" "website-bucket" {
    bucket          = var.website-bucket
    force_destroy   = true
    acl             = "public-read"

    versioning {
        enabled = true
    }
}

resource "aws_s3_bucket_website_configuration" "website-bucket-config" {
    bucket = aws_s3_bucket.website-bucket

    index_document {
      suffix = "index.html"
    }

    error_document {
      key = "error.html"
    }
}
