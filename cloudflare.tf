provider "cloudflare" {
    email = data.aws_ssm_parameter.CLOUDFLARE_EMAIL
    api_key = data.aws_ssm_parameter.CLOUDFLARE_API_KEY
}

resource "cloudflare_record" "www" {
    name = "www"
    zone_id = data.aws_ssm_parameter.CLOUDFLARE_ZONE_ID
    type = "CNAME"
    value = "x.com"
    ttl = 3600
}