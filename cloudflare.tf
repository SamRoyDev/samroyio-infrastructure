provider "cloudflare" {
    email = var.CLOUDFLARE_EMAIL
    api_key = var.CLOUDFLARE_API_KEY
}

resource "cloudflare_record" "www" {
    name = "www"
    zone_id = var.CLOUDFLARE_ZONE_ID
    type = "CNAME"
    value = "x.com"
    ttl = 3600
}