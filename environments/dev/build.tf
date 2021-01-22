module "build_infra" {
  source                     = "../../modules"
  tags                       = var.tags
  resource_group_inputs      = var.resource_group_inputs
  keyvault_inputs            = var.keyvault_inputs
  mount_volume_inputs        = var.mount_volume_inputs
  database_inputs            = var.database_inputs
  monitoring_inputs          = var.monitoring_inputs
  network_inputs             = var.network_inputs
  webapp_service_plan_inputs = var.webapp_service_plan_inputs
  webapp_inputs              = var.webapp_inputs
}
