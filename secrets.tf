data "aws_ssm_parameter" "CLOUDFLARE_API_KEY" {
  name = "CLOUDFLARE_API_KEY"
}

data "aws_ssm_parameter" "CLOUDFLARE_EMAIL" {
  name = "CLOUDFLARE_EMAIL"
}

data "aws_ssm_parameter" "CLOUDFLARE_ZONE_ID" {
  name = "CLOUDFLARE_ZONE_ID"
}