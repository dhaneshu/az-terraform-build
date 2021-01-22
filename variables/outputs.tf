output "tags" {
  # From variables/tags.tf file
  value = lookup(var.tags, var.environment, {})
}

output "monitoring_inputs" {
  # From variables/monitor.tf file
  value = lookup(var.monitoring_inputs, var.environment, {})
}

output "resource_group_inputs" {
  # From variables/basic_inputs.tf file
  value = lookup(var.resource_group_inputs, var.environment, {})
}

output "keyvault_inputs" {
  # From variables/basic_inputs.tf file
  value = lookup(var.keyvault_inputs, var.environment, {})
}

output "mount_volume_inputs" {
  # From variables/basic_inputs.tf file
  value = lookup(var.mount_volume_inputs, var.environment, {})
}
output "database_inputs" {
  # From variables/database.tf file
  value = lookup(var.database_inputs, var.environment, {})
}

output "network_inputs" {
  # From variables/network.tf file
  value = lookup(var.network_inputs, var.environment, {})
}

output "webapp_service_plan_inputs" {
  # From variables/webapp.tf file
  value = lookup(var.webapp_service_plan_inputs, var.environment, {})
}

output "webapp_inputs" {
  # From variables/webapp.tf file
  value = lookup(var.webapp_inputs, var.environment, {})
}
