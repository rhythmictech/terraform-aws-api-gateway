
module "example_api_gateway" {
  source = "../.."

  name                     = "test"
  domain_name              = "test-api.sblack.rocks"
  regional_certificate_arn = "arn:aws:acm:us-east-1:784384215106:certificate/6e8becd7-349e-48bf-b11b-97f4c7e901c8"
  stage_name               = "test"
  tags = {
    delete_me   = "please"
    Environment = "sandbox"
    whodunnit   = "@sblack4"
  }
}

output "example" {
  value = module.example_api_gateway
}
