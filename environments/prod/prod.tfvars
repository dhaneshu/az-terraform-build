tags = {}

keyvault_inputs = {
  kv_name = "kv-prod-keyvault-webapp"
}

resource_group_inputs = {
  uksouth = {
    rg_name     = "rg-prod-webapp-uks"
    rg_location = "uksouth"
  }
  ukwest = {
    rg_name     = "rg-prod-webapp-ukw"
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
    mysql_server_name                 = "sqldb-prod-webapp-uks"
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

    DB_Name      = "sqldb-prod-uks"
    DB_charset   = "utf8"
    DB_collation = "utf8_unicode_ci"

  }
  ukwest = {
    mysql_server_name                 = "sqldb-prod-webapp-ukw"
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

    DB_Name      = "sqldb-prod-ukw"
    DB_charset   = "utf8"
    DB_collation = "utf8_unicode_ci"

  }
}


monitoring_inputs = {
  app_insights_name = "myappinsight"
}


network_inputs = {
  uksouth = {
    vnet_name                             = "vnet-prod-uks"
    vnet_address_space                    = ["10.0.0.0/16"]
    integrationsubnet_name                = "integrationsubnet"
    integrationsubnet_address_prefixes    = ["10.0.1.0/24"]
    endpointsubnetsubnet_name             = "endpointsubnet"
    endpointsubnetsubnet_address_prefixes = ["10.0.2.0/24"]
  }
  ukwest = {
    vnet_name                             = "vnet-prod-ukw"
    vnet_address_space                    = ["10.0.0.0/16"]
    integrationsubnet_name                = "integrationsubnet"
    integrationsubnet_address_prefixes    = ["10.0.1.0/24"]
    endpointsubnetsubnet_name             = "endpointsubnet"
    endpointsubnetsubnet_address_prefixes = ["10.0.2.0/24"]
  }
}


webapp_service_plan_inputs = {
  uksouth = {
    service_plan_name     = "my-appserviceplan-uks"
    service_plan_kind     = "Linux"
    service_plan_reserved = true
    service_plan_tier     = "Standard"
    service_plan_size     = "S1"
  }
  ukwest = {
    service_plan_name     = "my-appserviceplan-ukw"
    service_plan_kind     = "Linux"
    service_plan_reserved = true
    service_plan_tier     = "Standard"
    service_plan_size     = "S1"
  }
}


webapp_inputs = {
  uksouth = {
    name = "webapp-prod-uks"
  }
  ukwest = {
    name = "webapp-prod-uks"
  }
}
