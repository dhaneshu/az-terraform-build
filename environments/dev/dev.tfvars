tags = {}

keyvault_inputs = {
  kv_name = "kv-dev-keyvault-webapp"
}

resource_group_inputs = {
  uksouth = {
    rg_name     = "rg-dev-webapp-uks"
    rg_location = "uksouth"
  }
  ukwest = {
    rg_name     = "rg-dev-webapp-ukw"
    rg_location = "ukwest"
  }
}

mount_volume_inputs = {
  sa_account_replication_type = "ZRS"
  sa_account_tier             = "Standard"
  sa_name                     = "strgdevappservice01"
  fileshare_name              = "assets"
  fileshare_quota             = 50
}



database_inputs = {
  uksouth = {
    mysql_server_name                 = "sqldb-dev-webapp-uks"
    sku_name                          = "B_Gen5_2"
    storage_mb                        = 5120
    version                           = "5.7"
    auto_grow_enabled                 = true
    backup_retention_days             = 7
    geo_redundant_backup_enabled      = false
    infrastructure_encryption_enabled = false
    public_network_access_enabled     = true
    ssl_enforcement_enabled           = true
    ssl_minimal_tls_version_enforced  = "TLS1_2"

    DB_Name      = "sqldb-dev-uks"
    DB_charset   = "utf8"
    DB_collation = "utf8_unicode_ci"

  }
  ukwest = {
    mysql_server_name                 = "sqldb-dev-webapp-ukw"
    sku_name                          = "B_Gen5_2"
    storage_mb                        = 5120
    version                           = "5.7"
    auto_grow_enabled                 = true
    backup_retention_days             = 7
    geo_redundant_backup_enabled      = false
    infrastructure_encryption_enabled = false
    public_network_access_enabled     = true
    ssl_enforcement_enabled           = true
    ssl_minimal_tls_version_enforced  = "TLS1_2"

    DB_Name      = "sqldb-dev-ukw"
    DB_charset   = "utf8"
    DB_collation = "utf8_unicode_ci"

  }
}


monitoring_inputs = {
  app_insights_name = "myappinsight"
}


network_inputs = {
  uksouth = {
    vnet_name                             = "vnet-dev-uks"
    vnet_address_space                    = ["10.0.0.0/16"]
    integrationsubnet_name                = "integrationsubnet-uks"
    integrationsubnet_address_prefixes    = ["10.0.1.0/24"]
    endpointsubnetsubnet_name             = "endpointsubnet-uks"
    endpointsubnetsubnet_address_prefixes = ["10.0.2.0/24"]
    appgatewaysubnet_name                 = "appgatewaysubnet-uks"
    appgatewaysubnet_address_prefixes     = ["10.0.3.0/24"]
    frontdoorsubnet_name                  = "frontdoorsubnet-uks"
    frontdoorsubnet_address_prefixes      = ["10.0.4.0/24"]

  }
  ukwest = {
    vnet_name                             = "vnet-dev-ukw"
    vnet_address_space                    = ["10.1.0.0/16"]
    integrationsubnet_name                = "integrationsubnet-ukw"
    integrationsubnet_address_prefixes    = ["10.1.1.0/24"]
    endpointsubnetsubnet_name             = "endpointsubnet-ukw"
    endpointsubnetsubnet_address_prefixes = ["10.1.2.0/24"]
    appgatewaysubnet_name                 = "appgatewaysubnet-ukw"
    appgatewaysubnet_address_prefixes     = ["10.1.3.0/24"]
    frontdoorsubnet_name                  = "frontdoorsubnet-ukw"
    frontdoorsubnet_address_prefixes      = ["10.1.4.0/24"]
  }
}


webapp_service_plan_inputs = {
  uksouth = {
    service_plan_name     = "my-appserviceplan-uks"
    service_plan_kind     = "Linux"
    service_plan_reserved = true
    service_plan_tier     = "PremiumV2"
    service_plan_size     = "P1v2"
  }
  ukwest = {
    service_plan_name     = "my-appserviceplan-ukw"
    service_plan_kind     = "Linux"
    service_plan_reserved = true
    service_plan_tier     = "PremiumV2"
    service_plan_size     = "P1v2"
  }
}


webapp_inputs = {
  uksouth = {
    name = "webapp-dev-uks"
  }
  ukwest = {
    name = "webapp-dev-ukw"
  }
}

app_gateway_inputs = {
  uksouth = {
    appgw_name           = "app-gateway-uks"
    ip_allocation_method = "Dynamic"
    ip_sku               = "Basic"
    sku = {
      name     = "Standard_Small"
      tier     = "Standard"
      capacity = 2
    }
    frontend_ports = [
      "443",
      "80"
    ]
    http_listeners = [
      {
        name     = "listener1"
        protocol = "http"
        port     = "80"
      }
      # {
      #   name     = "listener2"
      #   protocol = "https"
      #   port     = "443"
      # }
    ]
    request_routing_rules = [
      {
        name         = "route1"
        rule_type    = "Basic"
        listenername = "listener1"
    }]
    authentication_certificate_configs = [
      # {
      #   name = ""
      #   data = ""
      # }
    ]
    ssl_certificates_configs = [
      # {
      #   name     = ""
      #   data     = ""
      #   password = ""
      # }
    ]
  }
  ukwest = {
    appgw_name           = "app-gateway-ukw"
    ip_allocation_method = "Dynamic"
    ip_sku               = "Basic"
    sku = {
      name     = "Standard_Small"
      tier     = "Standard"
      capacity = 2
    }
    frontend_ports = [
      "443",
      "80"
    ]
    http_listeners = [
      {
        name     = "listener1"
        protocol = "http"
        port     = "80"
      }
      # {
      #   name     = "listener2"
      #   protocol = "https"
      #   port     = "443"
      # }
    ]
    request_routing_rules = [
      {
        name         = "route1"
        rule_type    = "Basic"
        listenername = "listener1"
      }
    ]
    authentication_certificate_configs = [
      # {
      #   name = ""
      #   data = ""
      # }
    ]
    ssl_certificates_configs = [
      # {
      #   name     = ""
      #   data     = ""
      #   password = ""
      # }
    ]
  }
}

frontdoor_inputs = {
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
