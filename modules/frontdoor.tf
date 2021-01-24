resource "azurerm_frontdoor" "frontdoor" {
  name                                         = var.frontdoor_inputs.name
  location                                     = "Global"
  resource_group_name                          = azurerm_resource_group.rg["uksouth"].name
  enforce_backend_pools_certificate_name_check = var.frontdoor_inputs.enforce_backend_pools_certificate_name_check

  routing_rule {
    name               = "${var.frontdoor_inputs.name}-route"
    accepted_protocols = var.frontdoor_inputs.routing_rule.accepted_protocols
    patterns_to_match  = var.frontdoor_inputs.routing_rule.patterns_to_match
    frontend_endpoints = ["${var.frontdoor_inputs.name}-endpoint1"]
    forwarding_configuration {
      forwarding_protocol = var.frontdoor_inputs.routing_rule.forwarding_protocol
      backend_pool_name   = var.frontdoor_inputs.backend_pool_name
    }
  }

  backend_pool_load_balancing {

    name = var.frontdoor_inputs.load_balancing_name
  }

  backend_pool_health_probe {
    name = var.frontdoor_inputs.health_probe_name
  }

  backend_pool {
    name = var.frontdoor_inputs.backend_pool_name
    backend {
      host_header = var.frontdoor_inputs.backend_pool.host_header
      address     = var.frontdoor_inputs.backend_pool.address
      http_port   = var.frontdoor_inputs.backend_pool.http_port
      https_port  = var.frontdoor_inputs.backend_pool.https_port
    }

    load_balancing_name = var.frontdoor_inputs.load_balancing_name
    health_probe_name   = var.frontdoor_inputs.health_probe_name
  }

  frontend_endpoint {
    name                              = "${var.frontdoor_inputs.name}-endpoint1"
    host_name                         = var.frontdoor_inputs.frontend_endpoint_host_name
    custom_https_provisioning_enabled = var.frontdoor_inputs.frontend_endpoint_custom_https_provisioning_enabled
  }
}
