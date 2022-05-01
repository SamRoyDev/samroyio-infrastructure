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
      suffix = "page-data/index.html"
    }
    error_document {
      key = "page-date/404.html"
    }
}

resource "aws_s3_bucket_policy" "allow_get" {
    bucket = aws_s3_bucket.website-bucket.id
    policy = data.aws_iam_policy_document.allow_get.json
}

data "aws_iam_policy_document" "allow_get" {
    statement {
      principals {
        type = "AWS"
        identifiers = ["*"]
      }

      actions = [
        "s3:GetObject"
      ]

      resources = [
        aws_s3_bucket.website-bucket.arn,
        "${aws_s3_bucket.website-bucket.arn}/*"
      ]
    }
}

resource "aws_s3_bucket" "website-bucket-subdomain" {
    bucket          = var.website-bucket-subdomain
    force_destroy   = true
}

resource "aws_s3_bucket_website_configuration" "website-bucket-subdomain" {
    bucket = aws_s3_bucket.website-bucket-subdomain.id
    redirect_all_requests_to {
      host_name = var.website-bucket
    }
}