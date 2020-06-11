
variable "access_log_format" {
  default     = "$context.identity.sourceIp $context.identity.caller $context.identity.user [$context.requestTime] $context.httpMethod $context.resourcePath $context.protocol $context.status $context.responseLength $context.requestId"
  description = "The formatting and values recorded in the logs. For more information on configuring the log format rules visit the AWS documentation"
  type        = string
}

variable "api_key_source" {
  default     = "HEADER" #tfsec:ignore:GEN001
  description = "The source of the API key for requests. Valid values are HEADER (default) and AUTHORIZER."
  type        = string
}

variable "binary_media_types" {
  default     = ["UTF-8-encoded"]
  description = "The list of binary media types supported by the RestApi. By default, the RestApi supports only UTF-8-encoded text payloads."
  type        = list
}

variable "domain_name" {
  description = "The fully-qualified domain name to register"
  type        = string
}

variable "identity_source" {
  default     = "method.request.header.x-api-key"
  description = <<EOT
The source of the identity in an incoming request.
For REQUEST type, this may be a comma-separated list of values, including headers, query string parameters and stage variables - e.g.
`"method.request.header.SomeHeaderName,method.request.querystring.SomeQueryStringName,stageVariables.SomeStageVariableName"`
EOT
  type        = string
}

variable "log_retention_in_days" {
  default     = 30
  description = "Days to retain apigateway logs"
  type        = number
}

variable "minimum_compression_size" {
  default     = -1
  description = "Minimum response size to compress for the REST API. Integer between -1 and 10485760 (10MB). Setting a value greater than -1 will enable compression, -1 disables compression (default)."
  type        = number
}

variable "name" {
  description = "Moniker to apply to all resources in the module"
  type        = string
}

variable "provider_arns" {
  default     = []
  description = <<EOT
A list of the Amazon Cognito user pool ARNs. Each element is of this format:
`arn:aws:cognito-idp:{region}:{account_id}:userpool/{user_pool_id}`.
EOT
  type        = list(string)
}

variable "regional_certificate_arn" {
  description = "The ARN for an AWS-managed certificate. AWS Certificate Manager is the only supported source."
  type        = string
}

variable "security_policy" {
  default     = "TLS_1_2"
  description = "The Transport Layer Security (TLS) version + cipher suite for this DomainName. The valid values are TLS_1_0 and TLS_1_2. Must be configured to perform drift detection."
  type        = string
}

variable "stage_name" {
  description = "The name of the stage"
  type        = string
}

variable "tags" {
  default     = {}
  description = "User-Defined tags"
  type        = map(string)
}

variable "triggers" {
  default     = {}
  description = <<EOT
A map of arbitrary keys and values that, when changed, will trigger a redeployment.
To force a redeployment without changing these keys/values, use the terraform taint command.
EOT
  type        = map(string)
}

variable "types" {
  type        = list(string)
  default     = ["EDGE"]
  description = <<EOT
A list of endpoint types. This resource currently only supports managing a single value.
Valid values: EDGE, REGIONAL or PRIVATE. If unspecified, defaults to EDGE. Must be declared as REGIONAL in non-Commercial partitions.
Refer to the documentation for more information on the difference between edge-optimized and regional APIs.
EOT
}

locals {
  name_prefix = "${var.name}-"
}
