data "cloudflare_ip_ranges" "cloudflare" {}

locals {
  bad_requests = trimspace(
    trimsuffix(
      templatefile(
        "${path.module}/templates/expr_bad_requests.tmpl",
        {
          paths = var.cf_blocked_paths
        }
      ), "or" # Shame that I cannot remove this in the first place in the template!
    )
  )
  bad_user_agents = trimspace(
    trimsuffix(
      templatefile(
        "${path.module}/templates/expr_bad_user_agents.tmpl",
        {
          user_agents = var.cf_block_user_agents
        }
      ), "or"
    )
  )
  js_challenge_country_codes = trimspace(
    trimsuffix(
      templatefile(
        "${path.module}/templates/expr_js_challenge_countries.tmpl",
        {
          country_codes = var.cf_js_challenge_country_codes
        }
      ), "or"
    )
  )
}
resource "cloudflare_zone" "site" {
  zone       = var.domain_name
  plan       = var.cf_plan_type
  type       = var.cf_zone_type
  jump_start = var.cf_jump_start
}

resource "cloudflare_zone_settings_override" "site" {
  zone_id = cloudflare_zone.site.id

  settings {
    always_online            = var.cf_always_online
    always_use_https         = var.cf_always_use_https
    automatic_https_rewrites = var.cf_automatic_https_rewrites
    brotli                   = var.cf_brotli
    browser_check            = var.cf_browser_check
    development_mode         = var.cf_development_mode
    email_obfuscation        = var.cf_email_obfuscation
    hotlink_protection       = var.cf_hotlink_protection
    # http2                  = # Apparently this is read-only on the API level
    http3          = var.cf_http3
    ip_geolocation = var.cf_ip_geolocation

    cache_level     = var.cf_cache_level
    min_tls_version = var.cf_min_tls_version
    security_level  = var.cf_security_level
    ssl             = var.cf_ssl_encryption_mode
    tls_1_3         = var.cf_allow_tls_1_3

    browser_cache_ttl = var.cf_browser_cache_ttl
    challenge_ttl     = var.cf_challenge_ttl

    minify {
      css  = var.cf_minify_css
      html = var.cf_minify_html
      js   = var.cf_minify_js
    }
  }
}

resource "cloudflare_filter" "bad_requests" {
  count       = length(local.bad_requests) == 0 ? 0 : 1
  zone_id     = cloudflare_zone.site.id
  description = "Block-script-kiddies"
  expression  = local.bad_requests
}

resource "cloudflare_firewall_rule" "bad_requests" {
  count       = length(local.bad_requests) == 0 ? 0 : 1
  zone_id     = cloudflare_zone.site.id
  description = "Block-script-kiddies"
  filter_id   = cloudflare_filter.bad_requests.0.id
  action      = "block"
}

resource "cloudflare_filter" "bad_user_agents" {
  count       = length(local.bad_user_agents) == 0 ? 0 : 1
  zone_id     = cloudflare_zone.site.id
  description = "Block-user-agents"
  expression  = local.bad_user_agents
}

resource "cloudflare_firewall_rule" "bad_user_agents" {
  count       = length(local.bad_user_agents) == 0 ? 0 : 1
  zone_id     = cloudflare_zone.site.id
  description = "Block-user-agents"
  filter_id   = cloudflare_filter.bad_user_agents.0.id
  action      = "block"
}

resource "cloudflare_filter" "js_challenge_countries" {
  count       = length(local.js_challenge_country_codes) == 0 ? 0 : 1
  zone_id     = cloudflare_zone.site.id
  description = "JS-Challenge-Countries"
  expression  = local.js_challenge_country_codes
}

resource "cloudflare_firewall_rule" "js_challenge_countries" {
  count       = length(local.js_challenge_country_codes) == 0 ? 0 : 1
  zone_id     = cloudflare_zone.site.id
  description = "JS-Challenge-Countries"
  filter_id   = cloudflare_filter.js_challenge_countries.0.id
  action      = "block"
}

resource "cloudflare_page_rule" "www_to_non_www" {
  zone_id  = cloudflare_zone.site.id
  target   = "https://www.${var.domain_name}/*"
  priority = 1
  status   = "active"

  actions {
    forwarding_url {
      url         = "https://${var.domain_name}/$1"
      status_code = 301
    }
  }
}

resource "cloudflare_record" "root" {
  depends_on = [
    cloudflare_zone.site,
    # data.cloudflare_zones.site,
  ]

  # zone_id = data.cloudflare_zones.site.id
  zone_id = cloudflare_zone.site.id
  name    = var.domain_name
  value   = aws_s3_bucket.site.website_endpoint
  type    = "CNAME"
  ttl     = 1 # Compulsory when proxied is true
  proxied = true
}

resource "cloudflare_record" "www" {
  depends_on = [
    cloudflare_zone.site,
    # data.cloudflare_zones.site,
  ]

  # zone_id = data.cloudflare_zones.site.id
  zone_id = cloudflare_zone.site.id
  name    = "www"
  value   = var.domain_name
  type    = "CNAME"
  ttl     = 1 # Compulsory when proxied is true
  proxied = true
}

data "aws_iam_policy_document" "only_from_cloudflare" {
  statement {
    sid = "redstrict-to-cloudflare"

    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${var.domain_name}",
      "arn:aws:s3:::${var.domain_name}/*",
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks
    }
  }
}

resource "aws_s3_bucket_policy" "site" {
  depends_on = [
    aws_s3_bucket.site
  ]
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.only_from_cloudflare.json
}

resource "aws_s3_bucket" "site" {
  bucket = var.domain_name
  acl    = "private"

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  tags = var.tags
}
