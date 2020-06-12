
output "domain_name_arn" {
  description = "Amazon Resource Name (ARN)"
  value       = aws_api_gateway_domain_name.this.arn
}

output "domain_name_id" {
  description = "The internal id assigned to this domain name by API Gateway."
  value       = aws_api_gateway_domain_name.this.id
}

output "api_gateway_rest_api_arn" {
  description = "Amazon Resource Name (ARN)"
  value       = aws_api_gateway_rest_api.this.arn
}

output "api_gateway_rest_api_id" {
  description = "The ID of the REST API"
  value       = aws_api_gateway_rest_api.this.id
}

output "api_gateway_authorizer_id" {
  description = "The ID of the Authorizer"
  value       = try(aws_api_gateway_authorizer.this[0].id, "")
}

output "cloudwatch_log_group_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group."
  value       = aws_cloudwatch_log_group.this.id
}
