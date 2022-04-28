provider "cloudflare" {
    email = data.aws_ssm_parameter.CLOUDFLARE_EMAIL.value
    api_key = data.aws_ssm_parameter.CLOUDFLARE_API_KEY.value
}

resource "cloudflare_record" "www" {
    name = "www"
    zone_id = data.aws_ssm_parameter.CLOUDFLARE_ZONE_ID.value
    type = "CNAME"
    value = aws_s3_bucket_website_configuration.website-bucket.website_endpoint
    ttl = 3600
}

resource "cloudflare_record" "@" {
    name = "@"
    zone_id = data.aws_ssm_parameter.CLOUDFLARE_ZONE_ID.value
    type = "CNAME"
    value = aws_s3_bucket_website_configuration.website-bucket.website_endpoint
    ttl = 3600
}