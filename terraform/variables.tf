variable "aws_region" {}
variable "aws_account_id" {}
variable "environment" {}
variable "image_tag" {}
variable "service_cpu" {}
variable "service_memory" {}
variable "service_replicas" {}

variable "canary" {
  default = null
  type = object({
    image_tag = string
    weight    = number
  })
}
