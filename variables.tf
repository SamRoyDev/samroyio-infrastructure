variable "region" {}
variable "website-bucket" {}
variable "website-bucket-backend" {}
variable "CLOUDFLARE_API_KEY" {
    type = string
    sensitive = true
}