resource "azurerm_public_ip" "pip" {
  for_each            = var.app_gateway_inputs
  name                = "${each.value.appgw_name}-pubip"
  resource_group_name = azurerm_resource_group.rg[each.key].name
  location            = azurerm_resource_group.rg[each.key].location
  allocation_method   = each.value.ip_allocation_method
  sku                 = each.value.ip_sku
  tags                = var.tags
}


resource "azurerm_application_gateway" "app_gateway" {
  for_each            = var.app_gateway_inputs
  depends_on          = [azurerm_public_ip.pip]
  name                = each.value.appgw_name
  resource_group_name = azurerm_resource_group.rg[each.key].name
  location            = "azurerm_resource_group.rg[each.key].location"

  sku {
    name     = lookup(each.value.sku, "name")
    tier     = lookup(each.value.sku, "tier")
    capacity = lookup(each.value.sku, "capacity")
  }

  gateway_ip_configuration {
    name      = "${each.value.appgw_name}-gwip"
    subnet_id = azurerm_subnet.appgatewaysubnet[each.key].id
  }

  dynamic "frontend_port" {
    for_each = each.value.frontend_ports
    content {
      name = "${each.value.appgw_name}-${frontend_port.value}-feport"
      port = frontend_port.value
    }
  }

  frontend_ip_configuration {
    name                 = "${each.value.appgw_name}-feip"
    public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }

  backend_address_pool {
    name  = "${each.value.appgw_name}-beap"
    fqdns = [azurerm_app_service.webapp[each.key].default_site_hostname]
  }


  probe {
    name                                      = "${each.value.appgw_name}-probe"
    protocol                                  = "Https"
    path                                      = "/"
    interval                                  = 30
    timeout                                   = 120
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true

  }

  backend_http_settings {
    name                                = "${each.value.appgw_name}-be-htst"
    probe_name                          = "${each.value.appgw_name}-probe"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 120
    pick_host_name_from_backend_address = true
  }


  dynamic "http_listener" {
    for_each = each.value.http_listeners
    content {
      name                           = "${each.value.appgw_name}-${http_listener.value.name}-httplstn"
      frontend_ip_configuration_name = "${each.value.appgw_name}-feip"
      frontend_port_name             = "${each.value.appgw_name}-${http_listener.value.port}-feport"
      protocol                       = http_listener.value.protocol
    }
  }

  dynamic "request_routing_rule" {
    for_each = each.value.request_routing_rules
    content {
      name                       = "${each.value.appgw_name}-${request_routing_rule.value.name}-rqrt"
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = "${each.value.appgw_name}-${request_routing_rule.value.listenername}-httplstn"
      backend_address_pool_name  = "${each.value.appgw_name}-beap"
      backend_http_settings_name = "${each.value.appgw_name}-be-htst"
    }
  }
  dynamic "ssl_certificate" {
    for_each = each.value.ssl_certificates_configs
    content {
      name     = lookup(ssl_certificate.value, "name")
      data     = filebase64(lookup(ssl_certificate.value, "data"))
      password = lookup(ssl_certificate.value, "password")
    }
  }
  dynamic "authentication_certificate" {
    for_each = each.value.authentication_certificate_configs
    content {
      name = lookup(authentication_certificate.value, "name")
      data = filebase64(lookup(authentication_certificate.value, "data"))
    }
  }
}
