variable "associate_ogp_function" {
  type        = bool
  default     = true
  description = "Toggleable associate ogp function for CloudFront. Example usecase: testing"
}

variable "service_name" {
  type        = string
  default     = "CustomOGP2ObsidianPublish"
  description = "Service name, used resources name prefix"
}

variable "route53_host_zone_id" {
  type        = string
  description = "Custom domain's host zone id in AWS Route53"
}

variable "fqdn" {
  type        = string
  description = "Cusotm domain's fqdn"
}

variable "obsidian_domain_name" {
  type        = string
  default     = "publish.obsidian.md"
  description = "Custom origin name"
}

variable "ssl_certificate_arn" {
  type        = string
  description = "Arn of your custom domain's SSL certificate as configured in AWS ACM"
}

variable "template" {
  type = object({
    BASE_URL    = string # https://md.kis9a.com
    TITLE       = string # md.kis9a.com 
    DESCRIPTION = string # Personal Knowledge site
    IMAGE       = string # https://kis9a.keybase.pub/kis9a.jpg
    IMAGE_TYPE  = string # image/jpeg
  })
  description = "Template variables for OGP response"
}
