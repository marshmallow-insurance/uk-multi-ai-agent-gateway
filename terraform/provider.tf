provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/terraform-execution"
  }

  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]

  default_tags {
    tags = {
      Terraform         = "true",
      product_region    = "uk",
      product           = "multi",
      service           = "ai-agent-gateway",
      team              = "core",
      service_full_name = "uk-multi-ai-agent-gateway",
    }
  }
}
