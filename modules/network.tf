

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.network_inputs
  name                = each.value.vnet_name
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  address_space       = each.value.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "integrationsubnet" {
  for_each             = var.network_inputs
  name                 = each.value.integrationsubnet_name
  resource_group_name  = azurerm_resource_group.rg[each.key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = each.value.integrationsubnet_address_prefixes
  delegation {
    name = "delegation"
    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action",
      ]
      name = "Microsoft.Web/serverFarms"
    }

  }
}

resource "azurerm_subnet" "endpointsubnet" {
  for_each                                       = var.network_inputs
  name                                           = each.value.endpointsubnetsubnet_name
  resource_group_name                            = azurerm_resource_group.rg[each.key].name
  virtual_network_name                           = azurerm_virtual_network.vnet[each.key].name
  address_prefixes                               = each.value.endpointsubnetsubnet_address_prefixes
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "appgatewaysubnet" {
  # lookup(var.network_inputs, "appgatewaysubnet_name", null)
  # for_each             = lookup(var.network_inputs, "appgatewaysubnet_name", null) != null ? var.network_inputs : {}
  for_each             = var.network_inputs
  name                 = each.value.appgatewaysubnet_name
  resource_group_name  = azurerm_resource_group.rg[each.key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = each.value.appgatewaysubnet_address_prefixes
}

resource "azurerm_subnet" "frontdoorsubnet" {
  # for_each             = lookup(var.network_inputs, "frontdoorsubnet_name", null) != null ? var.network_inputs : {}
  for_each             = var.network_inputs
  name                 = each.value.frontdoorsubnet_name
  resource_group_name  = azurerm_resource_group.rg[each.key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = each.value.frontdoorsubnet_address_prefixes
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnetintegrationconnection" {
  for_each       = var.network_inputs
  app_service_id = azurerm_app_service.webapp[each.key].id
  subnet_id      = azurerm_subnet.integrationsubnet[each.key].id
}

resource "azurerm_private_dns_zone" "dnsprivatezone" {
  for_each            = var.network_inputs
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.rg[each.key].name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "dnszonelink" {
  for_each              = var.network_inputs
  name                  = "dnszonelink-${each.key}"
  resource_group_name   = azurerm_resource_group.rg[each.key].name
  private_dns_zone_name = azurerm_private_dns_zone.dnsprivatezone[each.key].name
  virtual_network_id    = azurerm_virtual_network.vnet[each.key].id
  tags                  = var.tags
  depends_on            = [azurerm_private_dns_zone.dnsprivatezone]
}

resource "azurerm_private_endpoint" "privateendpoint" {
  for_each            = var.network_inputs
  name                = "webappprivateendpoint-${each.key}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  subnet_id           = azurerm_subnet.endpointsubnet[each.key].id

  private_dns_zone_group {
    name                 = "privatednszonegroup${each.key}"
    private_dns_zone_ids = [azurerm_private_dns_zone.dnsprivatezone[each.key].id]
  }

  private_service_connection {
    name                           = "privateendpointconnection${each.key}"
    private_connection_resource_id = azurerm_app_service.webapp[each.key].id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
  tags       = var.tags
  depends_on = [azurerm_app_service.webapp]
}
