output "api_gateway_url" {
  value = module.api_gateway.this_apigatewayv2_api_api_endpoint
}

output "api_gateway_domain" {
  value = aws_route53_record.ext_api_gateway_1.fqdn
}
