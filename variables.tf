
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

variable "minimum_compression_size" {
  default     = -1
  description = "Minimum response size to compress for the REST API. Integer between -1 and 10485760 (10MB). Setting a value greater than -1 will enable compression, -1 disables compression (default)."
  type        = number
}

variable "name" {
  description = "Moniker to apply to all resources in the module"
  type        = string
}

variable "tags" {
  default     = {}
  description = "User-Defined tags"
  type        = map(string)
}

variable "types" {
  type        = list
  default     = ["EDGE"]
  description = <<EOT
A list of endpoint types. This resource currently only supports managing a single value.
Valid values: EDGE, REGIONAL or PRIVATE. If unspecified, defaults to EDGE. Must be declared as REGIONAL in non-Commercial partitions.
Refer to the documentation for more information on the difference between edge-optimized and regional APIs.
EOT
}
