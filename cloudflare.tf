provider "cloudflare" {
    email = data.aws_ssm_parameter.CLOUDFLARE_EMAIL.value
    api_key = data.aws_ssm_parameter.CLOUDFLARE_API_KEY.value
}

resource "cloudflare_record" "www" {
    name = "www"
    zone_id = data.aws_ssm_parameter.CLOUDFLARE_ZONE_ID.value
    type = "CNAME"
    value = aws_s3_bucket_website_configuration.website-bucket.website_endpoint
    ttl = 1
    proxied = true
}

resource "cloudflare_record" "root" {
    name = "@"
    zone_id = data.aws_ssm_parameter.CLOUDFLARE_ZONE_ID.value
    type = "CNAME"
    value = aws_s3_bucket_website_configuration.website-bucket.website_endpoint
    ttl = 1
    proxied = true
}

resource "cloudflare_page_rule" "http_https_root" {
    zone_id = data.aws_ssm_parameter.CLOUDFLARE_ZONE_ID.value
    target = "${var.website-bucket}/*"

    actions {
      always_use_https = true
    }
}

resource "cloudflare_page_rule" "http_https_subdomain" {
    zone_id = data.aws_ssm_parameter.CLOUDFLARE_ZONE_ID.value
    target = "${var.website-bucket-subdomain}/*"

    actions {
      forwarding_url {
        url = "https://${var.website-bucket}/$1"
        status_code = 301
      }
    }
}

