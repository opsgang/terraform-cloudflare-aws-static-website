# Overview

This terraform module creates an S3 bucket on AWS and CloudFlare configuration for serving static websites from the bucket.

## Example use cases

* [Hugo](https://gohugo.io) + S3 + CloudFlare = <https://github.com/leventyalcin/leventyalcin-com>

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | ~> 3.53 |
| cloudflare | ~> 2.25 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.53 |
| cloudflare | ~> 2.25 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cf\_plan\_type | Whether Cloudflare plan is free or paid | `string` | n/a | yes |
| cf\_zone\_type | Whether the DNS Zone will be on Cloudflare or not | `string` | n/a | yes |
| domain\_name | DNS Zone to use | `string` | n/a | yes |
| cf\_allow\_tls\_1\_3 | Enable the latest version of the TLS protocol for improved security and performance. | `string` | `"on"` | no |
| cf\_always\_online | Enable/disable WayBackMachine during an outage | `string` | `"on"` | no |
| cf\_always\_use\_https | Auto redirect http to https | `string` | `"on"` | no |
| cf\_automatic\_https\_rewrites | Automatic HTTPS Rewrites helps fix mixed content by changing “http” to “https” for all resources or links on your web site that can be served with HTTPS. | `string` | `"on"` | no |
| cf\_block\_user\_agents | Block User Agents | `list(string)` | `[]` | no |
| cf\_blocked\_paths | Block URI Paths | `list(string)` | `[]` | no |
| cf\_brotli | Speed up page load times for your visitor’s HTTPS traffic by applying Brotli compression. | `string` | `"on"` | no |
| cf\_browser\_cache\_ttl | Determine the length of time Cloudflare instructs a visitor’s browser to cache files. | `number` | `14400` | no |
| cf\_browser\_check | Evaluate HTTP headers from your visitors browser for threats. If a threat is found a block page will be delivered. | `string` | `"on"` | no |
| cf\_cache\_level | Determine how much of your website’s static content you want Cloudflare to cache. | `string` | `"aggressive"` | no |
| cf\_challenge\_ttl | Specify the length of time that a visitor, who has successfully completed a Captcha or JavaScript Challenge, can access your website | `number` | `1800` | no |
| cf\_development\_mode | Temporarily bypass our cache allowing you to see changes to your origin server in realtime. | `string` | `"off"` | no |
| cf\_email\_obfuscation | Display obfuscated email addresses on your website to prevent harvesting by bots and spammers. | `string` | `"off"` | no |
| cf\_hotlink\_protection | Protect your images from off-site linking. | `string` | `"off"` | no |
| cf\_http3 | Accelerates HTTP requests by using QUIC, which provides encryption and performance improvements compared to TCP and TLS. | `string` | `"on"` | no |
| cf\_ip\_geolocation | Include the country code of the visitor location with all requests to your website. | `string` | `"on"` | no |
| cf\_js\_challenge\_country\_codes | Use JS Challenge for the country codes | `list(string)` | `[]` | no |
| cf\_jump\_start | Should Cloudflare scan your DNS zones initially? | `bool` | `true` | no |
| cf\_min\_tls\_version | Only allow HTTPS connections from visitors that support the selected TLS protocol version or newer. | `string` | `"1.2"` | no |
| cf\_minify\_css | Disable/enable CSS minification | `string` | `"on"` | no |
| cf\_minify\_html | Disable/enable HTML minification | `string` | `"off"` | no |
| cf\_minify\_js | Disable/enable JavaScript minification | `string` | `"on"` | no |
| cf\_security\_level | n/a | `string` | `"high"` | no |
| cf\_ssl\_encryption\_mode | Choose e2e encryption option | `string` | `"full"` | no |
| tags | AWS Tags to use on the resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_name | n/a |
| cf\_name\_servers | n/a |
| cf\_verification\_code | n/a |
