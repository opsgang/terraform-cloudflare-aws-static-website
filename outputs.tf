output "bucket_name" {
  value = aws_s3_bucket.site.bucket
}

output "cf_name_servers" {
  value = var.cf_zone_type == "full" ? cloudflare_zone.site.name_servers : [""]
}

output "cf_verification_code" {
  value = var.cf_zone_type == "partial" ? cloudflare_zone.site.verification_key : ""
}
