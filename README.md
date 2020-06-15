# terraform-aws-api-gateway [![](https://github.com/rhythmictech/terraform-aws-api-gateway/workflows/pre-commit-check/badge.svg)](https://github.com/rhythmictech/terraform-aws-api-gateway/actions) <a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=RhythmicTech" alt="follow on Twitter"></a>
Creates an API Gateway with:
- CloudWatch logging
- Regional Domain Name
- Optional Authorizer

## About
AWS API Gateway is commonly used to publicly expose a series of AWS Lambdas or ECS Services. It enables all sorts of goodies like a Web Application Firewall (WAF), access logging, and authentication. API Gateway deployments have a few main steps:

0. Create the Actual APIs
1. Create the API Gateway (this module)
2. Populate the API Methods. You can do this just by uploading a swagger file
3. Deploy to a stage of the API

## Example
Here's what using the module will look like. See the [examples](examples) for more.
```hcl
module "example" {
  source  = "rhythmictech/api-gateway/aws
  version = "1.0.0"

  name                     = "test"
  domain_name              = "test-api.sblack.rocks"
  regional_certificate_arn = "arn:aws:acm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:certificate/6e8becd7-349e-48bf-b11b-97f4c7e901c8"
  tags = {
    delete_me   = "please"
    Environment = "sandbox"
    whodunnit   = "@sblack4"
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |
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
| api\_key\_source | The source of the API key for requests. Valid values are HEADER (default) and AUTHORIZER. | `string` | `"HEADER"` | no |
| binary\_media\_types | The list of binary media types supported by the RestApi. By default, the RestApi supports only UTF-8-encoded text payloads. | `list` | <pre>[<br>  "UTF-8-encoded"<br>]</pre> | no |
| identity\_source | The source of the identity in an incoming request.<br>For REQUEST type, this may be a comma-separated list of values, including headers, query string parameters and stage variables - e.g.<br>`"method.request.header.SomeHeaderName,method.request.querystring.SomeQueryStringName,stageVariables.SomeStageVariableName"` | `string` | `"method.request.header.x-api-key"` | no |
| log\_retention\_in\_days | Days to retain apigateway logs | `number` | `30` | no |
| minimum\_compression\_size | Minimum response size to compress for the REST API. Integer between -1 and 10485760 (10MB). Setting a value greater than -1 will enable compression, -1 disables compression (default). | `number` | `-1` | no |
| provider\_arns | A list of the Amazon Cognito user pool ARNs. Each element is of this format:<br>`arn:aws:cognito-idp:{region}:{account_id}:userpool/{user_pool_id}`. | `list(string)` | `[]` | no |
| security\_policy | The Transport Layer Security (TLS) version + cipher suite for this DomainName. The valid values are TLS\_1\_0 and TLS\_1\_2. Must be configured to perform drift detection. | `string` | `"TLS_1_2"` | no |
| tags | User-Defined tags | `map(string)` | `{}` | no |
| types | A list of endpoint types. This resource currently only supports managing a single value.<br>Valid values: EDGE, REGIONAL or PRIVATE. If unspecified, defaults to EDGE. Must be declared as REGIONAL in non-Commercial partitions.<br>Refer to the documentation for more information on the difference between edge-optimized and regional APIs. | `list(string)` | <pre>[<br>  "EDGE"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| api\_gateway\_authorizer\_id | The ID of the Authorizer |
| api\_gateway\_rest\_api\_arn | Amazon Resource Name (ARN) |
| api\_gateway\_rest\_api\_id | The ID of the REST API |
| cloudwatch\_log\_group\_arn | The Amazon Resource Name (ARN) specifying the log group. |
| domain\_name\_arn | Amazon Resource Name (ARN) |
| domain\_name\_id | The internal id assigned to this domain name by API Gateway. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## The Giants underneath this module
- pre-commit.com/
- terraform.io/
- github.com/tfutils/tfenv
- github.com/segmentio/terraform-docs
