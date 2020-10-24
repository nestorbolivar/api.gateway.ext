data "aws_route53_zone" "root_dns_domain" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "ext_api_gateway_1" {
  zone_id = data.aws_route53_zone.root_dns_domain.zone_id
  name    = "apigate"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 100
  }

  set_identifier = "main"
  records        = [replace(module.api_gateway.this_apigatewayv2_api_api_endpoint, "https://", "")]
}
