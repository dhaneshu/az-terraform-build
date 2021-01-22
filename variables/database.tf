variable "database_inputs" {
  default = {
    dev = {
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
    prod = {}
  }
}
