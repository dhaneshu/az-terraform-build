variable "tags" {
  type = map(any)
}
variable "resource_group_inputs" {
  type = map(any)
}

variable "keyvault_inputs" {
  type = map(any)

}

variable "mount_volume_inputs" {
  type = map(any)
}


variable "database_inputs" {
  type = map(any)
}

variable "monitoring_inputs" {
  type = map(any)
}

variable "network_inputs" {
  type = map(any)
}

variable "webapp_service_plan_inputs" {
  type = map(any)
}

variable "webapp_inputs" {
  type = map(any)
}

variable "app_gateway_inputs" {
  type = map(any)

}
variable "frontdoor_inputs" {
  default = {
    name                                         = "myprodfrontdoor1"
    enforce_backend_pools_certificate_name_check = false
    backend_pool_name                            = "Backendweb"
    routing_rule = {
      accepted_protocols  = ["Http", "Https"]
      forwarding_protocol = "MatchRequest"
      patterns_to_match   = ["/*"]
    }
    backend_pool = {
      host_header = "www.mytestwebbackend.com"
      address     = "www.mytestwebbackend.com"
      http_port   = 80
      https_port  = 443
    }
    load_balancing_name                                 = "LoadBalancingSettings1"
    health_probe_name                                   = "HealthProbeSetting1"
    frontend_endpoint_host_name                         = "example-FrontDoor.azurefd.net"
    frontend_endpoint_custom_https_provisioning_enabled = false
  }

}
