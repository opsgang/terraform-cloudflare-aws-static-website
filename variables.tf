variable "domain_name" {
  description = "DNS Zone to use"
  type        = string
}

variable "cf_allow_tls_1_3" {
  description = "Enable the latest version of the TLS protocol for improved security and performance."
  type        = string
  default     = "on"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_allow_tls_1_3))
    error_message = "The value can be on|off."
  }
}

variable "cf_always_online" {
  description = "Enable/disable WayBackMachine during an outage"
  type        = string
  default     = "on"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_always_online))
    error_message = "The value can be on|off."
  }
}

variable "cf_always_use_https" {
  description = "Auto redirect http to https"
  type        = string
  default     = "on"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_always_use_https))
    error_message = "The value can be on|off."
  }
}

variable "cf_automatic_https_rewrites" {
  description = "Automatic HTTPS Rewrites helps fix mixed content by changing “http” to “https” for all resources or links on your web site that can be served with HTTPS."
  type        = string
  default     = "on"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_automatic_https_rewrites))
    error_message = "The value can be on|off."
  }
}

variable "cf_block_user_agents" {
  description = "Block User Agents"
  type        = list(string)

  default = []
}

variable "cf_blocked_paths" {
  description = "Block URI Paths"
  type        = list(string)
  default     = []
}

variable "cf_brotli" {
  description = "Speed up page load times for your visitor’s HTTPS traffic by applying Brotli compression."
  type        = string
  default     = "on"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_brotli))
    error_message = "The value can be on|off."
  }
}

variable "cf_browser_cache_ttl" {
  description = "Determine the length of time Cloudflare instructs a visitor’s browser to cache files."
  type        = number
  default     = 14400

  validation {
    condition = contains(
      [0, 30, 60, 300, 1200, 1800, 3600, 7200, 10800, 14400, 18000, 28800,
        43200, 57600, 72000, 86400, 172800, 259200, 345600, 432000, 691200,
        1382400, 2073600, 2678400, 5356800, 16070400, 31536000
      ],
      var.cf_browser_cache_ttl
    )
    error_message = "Invalid value. Please check the condition."
  }
}

variable "cf_browser_check" {
  description = "Evaluate HTTP headers from your visitors browser for threats. If a threat is found a block page will be delivered."
  type        = string
  default     = "on"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_browser_check))
    error_message = "The value can be on|off."
  }
}

variable "cf_cache_level" {
  description = "Determine how much of your website’s static content you want Cloudflare to cache."
  type        = string
  default     = "aggressive"

  validation {
    condition     = can(regex("^(bypass|basic|simplified|aggressive|cache_everything)$", var.cf_cache_level))
    error_message = "Invalid value. Please check the documentation."
  }
}

variable "cf_challenge_ttl" {
  description = "Specify the length of time that a visitor, who has successfully completed a Captcha or JavaScript Challenge, can access your website"
  type        = number
  default     = 1800
}

variable "cf_development_mode" {
  description = "Temporarily bypass our cache allowing you to see changes to your origin server in realtime."
  type        = string
  default     = "off"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_development_mode))
    error_message = "The value can be on|off."
  }
}

variable "cf_email_obfuscation" {
  description = "Display obfuscated email addresses on your website to prevent harvesting by bots and spammers."
  type        = string
  default     = "off"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_email_obfuscation))
    error_message = "The value can be on|off."
  }
}

variable "cf_hotlink_protection" {
  description = "Protect your images from off-site linking."
  type        = string
  default     = "off"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_hotlink_protection))
    error_message = "The value can be on|off."
  }
}

variable "cf_http3" {
  description = "Accelerates HTTP requests by using QUIC, which provides encryption and performance improvements compared to TCP and TLS."
  type        = string
  default     = "on"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_http3))
    error_message = "The value can be on|off."
  }
}

variable "cf_ip_geolocation" {
  description = "Include the country code of the visitor location with all requests to your website."
  type        = string
  default     = "on"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_ip_geolocation))
    error_message = "The value can be on|off."
  }
}

variable "cf_js_challenge_country_codes" {
  description = "Use JS Challenge for the country codes"
  type        = list(string)

  default = []
}

variable "cf_jump_start" {
  description = "Should Cloudflare scan your DNS zones initially?"
  type        = bool
  default     = true
}

variable "cf_min_tls_version" {
  description = "Only allow HTTPS connections from visitors that support the selected TLS protocol version or newer."
  type        = string
  default     = "1.2"

  validation {
    condition     = can(regex("^(1\\.[0-3])$", var.cf_min_tls_version))
    error_message = "Invalid value. [1.0, 1.1, 1.2, 1.3]."
  }
}

variable "cf_minify_css" {
  description = "Disable/enable CSS minification"
  type        = string
  default     = "on"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_minify_css))
    error_message = "The value can be on|off."
  }
}

variable "cf_minify_html" {
  description = "Disable/enable HTML minification"
  type        = string
  default     = "off"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_minify_html))
    error_message = "The value can be on|off."
  }
}

variable "cf_minify_js" {
  description = "Disable/enable JavaScript minification"
  type        = string
  default     = "on"

  validation {
    condition     = can(regex("^o(n|ff)$", var.cf_minify_js))
    error_message = "The value can be on|off."
  }
}

variable "cf_plan_type" {
  description = "Whether Cloudflare plan is free or paid"
  type        = string

  validation {
    condition     = can(regex("^(free|pro|business|enterprise)$", var.cf_plan_type))
    error_message = "Invalid value. Please check the documentation for valid values."
  }
}

variable "cf_security_level" {
  description = ""
  type        = string
  default     = "high"

  validation {
    condition     = can(regex("^(essentially_off|low|medium|high|under_attack)$", var.cf_security_level))
    error_message = "Invalid value. Please check the documentation."
  }
}

variable "cf_ssl_encryption_mode" {
  description = "Choose e2e encryption option"
  type        = string
  default     = "full"

  validation {
    condition     = can(regex("^(off|flexible|full|strict|origin_pull)$", var.cf_ssl_encryption_mode))
    error_message = "Invalid value. Please check the documentation."
  }
}

variable "cf_zone_type" {
  description = "Whether the DNS Zone will be on Cloudflare or not"
  type        = string

  validation {
    condition     = can(regex("^(full|partial)$", var.cf_zone_type))
    error_message = "Invalid value. Please check the documentation for valid values."
  }
}

variable "tags" {
  description = "AWS Tags to use on the resources"
  type        = map(any)
  default     = {}
}
