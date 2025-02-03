terraform {
  backend "s3" {
    key            = "uk-multi-ai-agent-gateway"
    encrypt        = "true"
    acl            = "private"
    dynamodb_table = "terraform-state-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }

  required_version = ">= 1.6.0"
}
