provider "cloudflare" {
    email = var.CLOUDFLARE_EMAIL
    api_key = var.CLOUDFLARE_API_KEY
    }

resource "cloudflare_record" "www" {
    name = "www"
    type = "CNAME"
    value = "x.com"
    ttl = 3600
}