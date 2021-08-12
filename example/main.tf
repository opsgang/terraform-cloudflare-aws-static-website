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

provider "aws" {}
provider "cloudflare" {}

locals {
  tags = {
    "aws-tag"     = "value"
    "environment" = "production"
  }
}

module "site" {
  source = "../"

  domain_name  = "mybeautifulpersonalwebsite.com"
  cf_plan_type = "flexible"
  cf_zone_type = "full"

  tags = local.tags
}
