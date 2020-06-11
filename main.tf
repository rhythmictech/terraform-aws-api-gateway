
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
}
