
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

module "example_api_gateway" {
  source = "../.."

  name                     = "test"
  domain_name              = "test-api.sblack.rocks"
  regional_certificate_arn = "arn:aws:acm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:certificate/6e8becd7-349e-48bf-b11b-97f4c7e901c8"
  tags = {
    delete_me   = "please"
    Environment = "sandbox"
    whodunnit   = "@sblack4"
  }
}

output "example" {
  value = module.example_api_gateway
}
