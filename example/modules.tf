module "customOGP2ObsidianPublish" {
  source               = "github.com/kis9a/CustomOGP2ObsidianPublish"
  fqdn                   = "md.kis9a.com"
  route53_host_zone_id   = data.terraform_remote_state.domains.outputs.kis9a_host_zone_id
  ssl_certificate_arn    = data.terraform_remote_state.domains.outputs.sub_kis9a_virginia_ssl_arn
  associate_ogp_function = true
  providers = {
    aws.virginia = aws.virginia
  }
  template = {
    BASE_URL    = "https://md.kis9a.com"
    TITLE       = "md.kis9a.com"
    DESCRIPTION = "Personal Knowledge site"
    IMAGE       = "https://kis9a.keybase.pub/kis9a.jpg"
    IMAGE_TYPE  = "image/jpeg"
  }
}
