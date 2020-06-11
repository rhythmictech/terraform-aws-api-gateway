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
| name | Moniker to apply to all resources in the module | `string` | n/a | yes |
| api\_key\_source | The source of the API key for requests. Valid values are HEADER (default) and AUTHORIZER. | `string` | `"HEADER"` | no |
| binary\_media\_types | The list of binary media types supported by the RestApi. By default, the RestApi supports only UTF-8-encoded text payloads. | `list` | <pre>[<br>  "UTF-8-encoded"<br>]</pre> | no |
| minimum\_compression\_size | Minimum response size to compress for the REST API. Integer between -1 and 10485760 (10MB). Setting a value greater than -1 will enable compression, -1 disables compression (default). | `number` | `-1` | no |
| tags | User-Defined tags | `map(string)` | `{}` | no |
| types | A list of endpoint types. This resource currently only supports managing a single value.<br>Valid values: EDGE, REGIONAL or PRIVATE. If unspecified, defaults to EDGE. Must be declared as REGIONAL in non-Commercial partitions.<br>Refer to the documentation for more information on the difference between edge-optimized and regional APIs. | `list` | <pre>[<br>  "EDGE"<br>]</pre> | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## The Giants underneath this module
- pre-commit.com/
- terraform.io/
- github.com/tfutils/tfenv
- github.com/segmentio/terraform-docs
