variable "tags" {
  type    = map(any)
  default = {}
}

variable "resource_group_inputs" {
  type = map(any)
  # default = {
  #   uksouth = {
  #     rg_name     = "rg-dev-webapp-uks"
  #     rg_location = "uksouth"
  #   }
  #   ukwest = {
  #     rg_name     = "rg-dev-webapp-ukw"
  #     rg_location = "ukwest"
  #   }
  # }
}
variable "keyvault_inputs" {
  type = map(any)
  # default = {
  #   kv_name = "kv-dev-keyvault-webapp"
  # }
}

variable "mount_volume_inputs" {
  type = map(any)
  # default = {
  #   sa_account_replication_type = "ZRS"
  #   sa_account_tier             = "Standard"
  #   sa_name                     = "strgdevappservice01"
  #   fileshare_name              = "assets"
  #   fileshare_quota             = 50
  # }
}


variable "database_inputs" {
  type = map(any)
  # default = {
  #   uksouth = {
  #     mysql_server_name                 = "sqldb-dev-webapp-uks"
  #     sku_name                          = "B_Gen5_2"
  #     storage_mb                        = 5120
  #     version                           = "5.7"
  #     auto_grow_enabled                 = true
  #     backup_retention_days             = 7
  #     geo_redundant_backup_enabled      = false
  #     infrastructure_encryption_enabled = false
  #     public_network_access_enabled     = true
  #     ssl_enforcement_enabled           = true
  #     ssl_minimal_tls_version_enforced  = "TLS1_2"

  #     DB_Name      = "sqldb-dev-uks"
  #     DB_charset   = "utf8"
  #     DB_collation = "utf8_unicode_ci"

  #   }
  #   ukwest = {
  #     mysql_server_name                 = "sqldb-dev-webapp-ukw"
  #     sku_name                          = "B_Gen5_2"
  #     storage_mb                        = 5120
  #     version                           = "5.7"
  #     auto_grow_enabled                 = true
  #     backup_retention_days             = 7
  #     geo_redundant_backup_enabled      = false
  #     infrastructure_encryption_enabled = false
  #     public_network_access_enabled     = true
  #     ssl_enforcement_enabled           = true
  #     ssl_minimal_tls_version_enforced  = "TLS1_2"

  #     DB_Name      = "sqldb-dev-ukw"
  #     DB_charset   = "utf8"
  #     DB_collation = "utf8_unicode_ci"

  #   }
  # }
}

variable "monitoring_inputs" {
  type = map(any)
  # default = {
  #   app_insights_name = "myappinsight"
  # }
}

variable "network_inputs" {
  type = map(any)
  # default = {
  #   uksouth = {
  #     vnet_name                             = "vnet-dev-uks"
  #     vnet_address_space                    = ["10.0.0.0/16"]
  #     integrationsubnet_name                = "integrationsubnet"
  #     integrationsubnet_address_prefixes    = ["10.0.1.0/24"]
  #     endpointsubnetsubnet_name             = "endpointsubnet"
  #     endpointsubnetsubnet_address_prefixes = ["10.0.2.0/24"]
  #   }
  #   ukwest = {
  #     vnet_name                             = "vnet-dev-ukw"
  #     vnet_address_space                    = ["10.0.0.0/16"]
  #     integrationsubnet_name                = "integrationsubnet"
  #     integrationsubnet_address_prefixes    = ["10.0.1.0/24"]
  #     endpointsubnetsubnet_name             = "endpointsubnet"
  #     endpointsubnetsubnet_address_prefixes = ["10.0.2.0/24"]
  #   }
  # }
}

variable "webapp_service_plan_inputs" {
  type = map(any)
  # default = {
  #   uksouth = {
  #     service_plan_name     = "my-appserviceplan-uks"
  #     service_plan_kind     = "Linux"
  #     service_plan_reserved = true
  #     service_plan_tier     = "Standard"
  #     service_plan_size     = "S1"
  #   }
  #   ukwest = {
  #     service_plan_name     = "my-appserviceplan-ukw"
  #     service_plan_kind     = "Linux"
  #     service_plan_reserved = true
  #     service_plan_tier     = "Standard"
  #     service_plan_size     = "S1"
  #   }
  # }
}

variable "webapp_inputs" {
  type = map(any)
  # default = {
  #   uksouth = {
  #     name = "webapp-dev-uks"
  #   }
  #   ukwest = {
  #     name = "webapp-dev-ukw"
  #   }
  # }
}

variable "app_gateway_inputs" {
  type = map(any)
  default = {

  }
}

variable "frontdoor_inputs" {
  # type = map(any)
  default = {
    name                                         = "myfrontdoor1"
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
