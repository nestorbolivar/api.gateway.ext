module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> v2.0"

  domain_name = "apigate.dev1.littlepayco.de"
  zone_id     = "Z2T0CVJY2U8B5V"

  subject_alternative_names = [
    "*.apigate.dev1.littlepayco.de",
  ]

  tags = {
    Name = "apigate.dev1.littlepayco.de"
  }
}

module "user_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 2.0"

  name = "api_gateway_ext"

  tags = {
    Service     = "user"
    Environment = "dev"
  }
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"


  function_name = "my-lambda1"
  description   = "My awesome lambda function"
  handler       = "ext.my_handler"
  runtime       = "python3.8"
  publish       = true

  source_path = "src/ext.py"

  allowed_triggers = {
    APIGatewayAny = {
      service = "apigateway"
      arn     = module.api_gateway.this_apigatewayv2_api_execution_arn
    }
  }


  tags = {
    Name = "my-lambda1"
  }
}

module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = "dev-http"
  description   = "My awesome HTTP API Gateway"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  # Custom domain
  domain_name                 = "apigate.dev1.littlepayco.de"
  domain_name_certificate_arn = module.acm.this_acm_certificate_arn

  # Access logs
  default_stage_access_log_destination_arn = "arn:aws:logs:ap-southeast-2:290102786741:log-group:api-log-group"
  default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  # Routes and integrations
  integrations = {
    "POST /" = {
      lambda_arn             = module.lambda_function.this_lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }

    "$default" = {
      lambda_arn = module.lambda_function.this_lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }
  }

  tags = {
    Name = "http-apigateway"
  }
}
