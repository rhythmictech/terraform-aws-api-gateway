########################################
# API Gateway
########################################

resource "aws_api_gateway_domain_name" "this" {
  domain_name              = var.domain_name
  regional_certificate_arn = var.regional_certificate_arn
  security_policy          = var.security_policy
  tags                     = var.tags

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_rest_api" "this" {
  name                     = var.name
  api_key_source           = var.api_key_source #tfsec:ignore:GEN003
  binary_media_types       = var.binary_media_types
  description              = coalesce(var.description, "${var.name} API Gateway. Terraform Managed.")
  minimum_compression_size = var.minimum_compression_size
  tags                     = var.tags

  endpoint_configuration {
    types = var.types
  }

  depends_on = [
    aws_api_gateway_rest_api.this
  ]
}

resource "aws_api_gateway_integration" "hello_world" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.hello_world.id
  http_method = aws_api_gateway_method.hello_world.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "production" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = "production"

  depends_on = [
    "aws_api_gateway_integration.hello_world",
  ]
}

resource "aws_api_gateway_base_path_mapping" "path_mapping" {
  base_path = "v1"

  api_id      = aws_api_gateway_rest_api.this.id
  domain_name = aws_api_gateway_domain_name.this.domain_name
  stage_name  = aws_api_gateway_deployment.production.stage_name
}

# /hello_world endpoint
resource "aws_api_gateway_resource" "hello_world" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "hello_world"
}

resource "aws_api_gateway_method" "hello_world" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.hello_world.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = try(aws_api_gateway_authorizer.this[0].id, null)
}

########################################
# Authorizer
########################################

resource "aws_api_gateway_authorizer" "this" {
  count           = length(var.provider_arns) < 1 ? 0 : 1
  name            = var.name
  identity_source = var.identity_source
  provider_arns   = var.provider_arns
  rest_api_id     = aws_api_gateway_rest_api.this.id
  type            = "COGNITO_USER_POOLS"
}

########################################
# Logging
########################################

resource "aws_cloudwatch_log_group" "this" {
  name_prefix       = local.name_prefix
  retention_in_days = var.log_retention_in_days
  tags              = var.tags
}
