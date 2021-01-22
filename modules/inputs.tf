module "vars" {
  source      = "../variables"
  environment = var.key
}

variable "key" {}

locals {
  environment = var.key
}
