########################################
# API Gateway
########################################

resource "aws_api_gateway_base_path_mapping" "this" {
  domain_name = aws_api_gateway_domain_name.this.domain_name
  api_id      = aws_api_gateway_rest_api.this.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  # TODO: use base_path for API versioning :D
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = var.stage_name
  # Error: Unsupported argument
  # An argument named "triggers" is not expected here.
  # triggers    = var.triggers

  lifecycle {
    create_before_destroy = true
  }
}

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
  description              = "${var.name} API Gateway. Terraform Managed."
  minimum_compression_size = var.minimum_compression_size
  tags                     = var.tags

  endpoint_configuration {
    types = var.types
  }

  depends_on = [
    aws_api_gateway_rest_api.this
  ]
}

resource "aws_api_gateway_stage" "this" {
  stage_name    = var.stage_name
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.this.arn
    format          = var.access_log_format
  }

  depends_on = [
    aws_api_gateway_deployment.this
  ]
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
