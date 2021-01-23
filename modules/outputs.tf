output "app_service_plan_id" {
  description = "Id of the App Service Plan"
  #   value       = app_plan
  value = {
    for instance in azurerm_app_service_plan.app_plan :
    instance.name => instance.id
    # if instance.associate_public_ip_address
  }
}

output "app_service_id" {
  description = "Id of the App Service"
  value = {
    for instance in azurerm_app_service.webapp :
    instance.name => instance.id
  }
}

# output "app_service_name" {
#   description = "Name of the App Service"
#   value       = {
#     for instance in azurerm_app_service.webapp :
#     instance.name => instance.id
#   }azurerm_app_service.app_service.name
# }

output "app_service_default_site_hostname" {
  description = "The Default Hostname associated with the App Service"
  value = {
    for instance in azurerm_app_service.webapp :
    instance.name => instance.default_site_hostname
  }
}

output "app_service_outbound_ip_addresses" {
  description = "Outbound IP adresses of the App Service"
  value = {
    for instance in azurerm_app_service.webapp :
    instance.name => split(",", instance.outbound_ip_addresses)
  }
}

output "app_service_possible_outbound_ip_addresses" {
  description = "Possible outbound IP adresses of the App Service"
  value = {
    for instance in azurerm_app_service.webapp :
    instance.name => split(",", instance.possible_outbound_ip_addresses)
  }
}


output "vnet_ids" {
  description = "Virtual Network IDs"
  value = {
    for instance in azurerm_virtual_network.vnet :
    instance.name => instance.id
  }
}

output "webapp_integrationsubnet_ids" {
  description = "WebApp Integration subnet IDs"
  value = {
    for instance in azurerm_subnet.integrationsubnet :
    instance.name => instance.id
  }
}

output "frontdoorsubnet_ids" {
  description = "WebApp Integration subnet IDs"
  value = {
    for instance in azurerm_subnet.frontdoorsubnet :
    instance.name => instance.id
  }
}
output "appgatewaysubnet_ids" {
  description = "WebApp Integration subnet IDs"
  value = {
    for instance in azurerm_subnet.appgatewaysubnet :
    instance.name => instance.id
  }
}
