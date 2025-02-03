locals {
  vpc_name = {
    staging    = "staging"
    production = "live"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_vpc" "auto_vpc" {
  filter {
    name   = "tag:Name"
    values = [local.vpc_name[var.environment]]
  }
}

data "aws_vpc" "central_vpc" {
  filter {
    name   = "tag:Name"
    values = ["central-${var.environment}"]
  }
}

data "aws_service_discovery_dns_namespace" "private" {
  name = "local"

  type = "DNS_PRIVATE"
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.auto_vpc.id]
  }
  filter {
    name = "tag:Name"
    values = [
      "${local.vpc_name[var.environment]}-private-eu-west-1a",
      "${local.vpc_name[var.environment]}-private-eu-west-1b",
      "${local.vpc_name[var.environment]}-private-eu-west-1c",
    ]
  }
}

data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

data "aws_subnets" "central_private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.central_vpc.id]
  }
  filter {
    name   = "tag:tier"
    values = ["private"]
  }
}

data "aws_subnet" "central_private" {
  for_each = toset(data.aws_subnets.central_private.ids)
  id       = each.value
}

data "aws_secretsmanager_secret" "datadog" {
  name = "datadog/api-key"
}

data "aws_iam_policy" "datadog" {
  name = "terraform-retrieve-datadog-api-key-secret-policy"
}
