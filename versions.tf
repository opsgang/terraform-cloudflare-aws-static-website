terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.53"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.25"
    }
  }
}
