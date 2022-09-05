locals {
  origin_id = "${var.service_name}-${var.fqdn}"
  lambda_function_associations = var.associate_ogp_function ? [{
    event_type   = "viewer-request"
    include_body = false
    lambda_arn   = aws_lambda_function.preq.qualified_arn
  }] : []
}

resource "aws_cloudfront_distribution" "service" {
  enabled = true
  aliases = [var.fqdn]

  origin {
    origin_id   = local.origin_id
    domain_name = var.obsidian_domain_name

    custom_header {
      name  = "x-obsidian-custom-domain"
      value = var.fqdn
    }

    custom_origin_config {
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
      http_port              = "80"
      https_port             = "443"
    }
  }

  default_cache_behavior {
    target_origin_id       = local.origin_id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]

    dynamic "lambda_function_association" {
      for_each = local.lambda_function_associations

      content {
        event_type   = lambda_function_association.value.event_type
        include_body = lambda_function_association.value.include_body
        lambda_arn   = lambda_function_association.value.lambda_arn
      }
    }

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.ssl_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}
