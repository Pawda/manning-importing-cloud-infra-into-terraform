// syntax is compatible with specific versions of Terraform, starting at 0.13
terraform {
  required_version = ">= 0.13.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "1.0.0"
    }
  }

  backend "s3" {
      bucket = "eu02-iq-tfstate"
      key = "poc/4.1/aws"
      region = "eu-west-1"
      encrypt = true
  }
}

// instantiate AWS provider with a region
provider "aws" {
  region = "eu-west-1"
}

// create 10 users
module "users" {
  source = "./modules/cloudesk-user/"
  for_each = toset([
    for i in range(10) : format("user-%02d", i)
  ])

  name = each.key

  providers = {
    aws = aws
  }
}

output "user_names" {
  value = [
    for u in module.users : u.user_name
  ]
}
output "user_arns" {
  value = [
    for u in module.users : u.user_arn
  ]
  sensitive = true
}
