module "metadata" {
  source         = "git@github.com:marshmallow-insurance/uk-auto-infrastructure.git//modules/service-metadata"
  product        = "multi"
  product_region = "uk"
  service_name   = "ai-agent-gateway"
  team           = "core"
}

module "ai_agent_gateway" {
  source                                     = "git@github.com:marshmallow-insurance/uk-auto-infrastructure.git//modules/java-ecs-service"
  service_name                               = module.metadata.service_name
  service_product                            = module.metadata.product
  service_geo_division                       = module.metadata.product_region
  team                                       = module.metadata.team
  image_tag                                  = var.image_tag
  vpc_id                                     = data.aws_vpc.central_vpc.id
  service_cpu                                = var.service_cpu
  service_memory                             = var.service_memory
  service_replica_count                      = var.service_replicas
  environment                                = var.environment
  private_dns_namespace_id                   = data.aws_service_discovery_dns_namespace.private.id
  ecs_cluster_id                             = "arn:aws:ecs:${var.aws_region}:${var.aws_account_id}:cluster/${var.environment}-cluster"
  private_subnets_ids                        = data.aws_subnets.central_private.ids
  ingress_cidr_blocks                        = concat(sort([for s in data.aws_subnet.private : s.cidr_block]), [for s in data.aws_subnet.central_private : s.cidr_block])
  datadog_api_key_secret_arn                 = data.aws_secretsmanager_secret.datadog.arn
  retrieve_datadog_api_key_secret_policy_arn = data.aws_iam_policy.datadog.arn
  service_discovery_enabled                  = true
  enable_appmesh_health_check                = true
  deployment_maximum_percent                 = 200
  appmesh_per_retry_timeout                  = 60
  appmesh_max_retries                        = 0
  service_discovery_namespace                = "local"
  canary                                     = var.canary
  enable_datadog_monitoring                  = true
  datadog_disable_warn_log_monitor           = true
  datadog_disable_error_log_monitor          = true
  additional_tags                            = module.metadata.cost_allocation_tags
  appmesh_backend_services                   = ["customer.local", "mta.local", "policy-group.local", "quote-matching-v2.local", "quoting.local", "renewals.local", "renewals-quoting.local", "vehicle-lookup.local"]
  environment_variables                      = []
  secret_names                               = []
}

# The resources below are commented out because AWS does not allow empty IAM policies. When you want to
# give permissions to this service, uncomment these resources and add the permissions to the policy document

# resource "aws_iam_policy" "ai_agent_gateway_task_role_policy" {
#   name        = "ai-agent-gateway-task-role-policy"
#   description = "Allows the task access to specified AWS resources"
#   policy      = data.aws_iam_policy_document.ai_agent_gateway_permissions.json
# }
#
# resource "aws_iam_role_policy_attachment" "ai_agent_gateway_task_role_policy_attachment" {
#   role       = module.ai_agent_gateway.task_role_name
#   policy_arn = aws_iam_policy.ai_agent_gateway_task_role_policy.arn
# }
#
# data "aws_iam_policy_document" "ai_agent_gateway_permissions" {}
