output "app_service_plan_id" {
  description = "Id of the App Service Plan"
  value       = module.build_infra.app_service_plan_id
}


output "app_service_id" {
  description = "Id of the App Service"
  value       = module.build_infra.app_service_id
}

output "app_service_default_site_hostname" {
  description = "The Default Hostname associated with the App Service"
  value       = module.build_infra.app_service_default_site_hostname
}

output "app_service_outbound_ip_addresses" {
  description = "Outbound IP adresses of the App Service"
  value       = module.build_infra.app_service_outbound_ip_addresses
}

output "app_service_possible_outbound_ip_addresses" {
  description = "Possible outbound IP adresses of the App Service"
  value       = module.build_infra.app_service_possible_outbound_ip_addresses
}


output "vnet_ids" {
  description = "Virtual Network IDs"
  value       = module.build_infra.vnet_ids
}

output "webapp_integrationsubnet_ids" {
  description = "WebApp Integration subnet IDs"
  value       = module.build_infra.webapp_integrationsubnet_ids
}

output "appgatewaysubnet_ids" {
  description = "WebApp Integration subnet IDs"
  value       = module.build_infra.appgatewaysubnet_ids
}
