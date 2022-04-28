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

resource "aws_s3_bucket" "website-bucket" {
    bucket          = var.website-bucket
    force_destroy   = true
}

resource "aws_s3_bucket_versioning" "website-bucket" {
    bucket          = aws_s3_bucket.website-bucket.id
    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_s3_bucket_acl" "website-bucket" {
    bucket          = aws_s3_bucket.website-bucket.id
    acl             = "public-read"    
}

resource "aws_s3_bucket_website_configuration" "website-bucket" {
    bucket = aws_s3_bucket.website-bucket.id
    index_document {
      suffix = "index.html"
    }
    error_document {
      key = "error.html"
    }
}
