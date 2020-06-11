# terraform-api-gateway [![](https://github.com/rhythmictech/terraform-api-gateway/workflows/pre-commit-check/badge.svg)](https://github.com/rhythmictech/terraform-api-gateway/actions) <a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=RhythmicTech" alt="follow on Twitter"></a>
Creates an API Gateway with:
- CloudWatch logging
- Domain Mapping
- Deployment

## Example
Here's what using the module will look like
```hcl
module "example" {
  source = "rhythmictech/terraform-mycloud-mymodule
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |
| aws | ~> 2.48.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.48.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain\_name | The fully-qualified domain name to register | `string` | n/a | yes |
| name | Moniker to apply to all resources in the module | `string` | n/a | yes |
| regional\_certificate\_arn | The ARN for an AWS-managed certificate. AWS Certificate Manager is the only supported source. | `string` | n/a | yes |
| stage\_name | The name of the stage | `string` | n/a | yes |
| access\_log\_format | The formatting and values recorded in the logs. For more information on configuring the log format rules visit the AWS documentation | `string` | `"$context.identity.sourceIp $context.identity.caller $context.identity.user [$context.requestTime] $context.httpMethod $context.resourcePath $context.protocol $context.status $context.responseLength $context.requestId"` | no |
| api\_key\_source | The source of the API key for requests. Valid values are HEADER (default) and AUTHORIZER. | `string` | `"HEADER"` | no |
| binary\_media\_types | The list of binary media types supported by the RestApi. By default, the RestApi supports only UTF-8-encoded text payloads. | `list` | <pre>[<br>  "UTF-8-encoded"<br>]</pre> | no |
| identity\_source | The source of the identity in an incoming request.<br>For REQUEST type, this may be a comma-separated list of values, including headers, query string parameters and stage variables - e.g.<br>`"method.request.header.SomeHeaderName,method.request.querystring.SomeQueryStringName,stageVariables.SomeStageVariableName"` | `string` | `"method.request.header.x-api-key"` | no |
| log\_retention\_in\_days | Days to retain apigateway logs | `number` | `30` | no |
| minimum\_compression\_size | Minimum response size to compress for the REST API. Integer between -1 and 10485760 (10MB). Setting a value greater than -1 will enable compression, -1 disables compression (default). | `number` | `-1` | no |
| provider\_arns | A list of the Amazon Cognito user pool ARNs. Each element is of this format:<br>`arn:aws:cognito-idp:{region}:{account_id}:userpool/{user_pool_id}`. | `list(string)` | `[]` | no |
| security\_policy | The Transport Layer Security (TLS) version + cipher suite for this DomainName. The valid values are TLS\_1\_0 and TLS\_1\_2. Must be configured to perform drift detection. | `string` | `"TLS_1_2"` | no |
| tags | User-Defined tags | `map(string)` | `{}` | no |
| triggers | A map of arbitrary keys and values that, when changed, will trigger a redeployment.<br>To force a redeployment without changing these keys/values, use the terraform taint command. | `map(string)` | `{}` | no |
| types | A list of endpoint types. This resource currently only supports managing a single value.<br>Valid values: EDGE, REGIONAL or PRIVATE. If unspecified, defaults to EDGE. Must be declared as REGIONAL in non-Commercial partitions.<br>Refer to the documentation for more information on the difference between edge-optimized and regional APIs. | `list(string)` | <pre>[<br>  "EDGE"<br>]</pre> | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## The Giants underneath this module
- pre-commit.com/
- terraform.io/
- github.com/tfutils/tfenv
- github.com/segmentio/terraform-docs
