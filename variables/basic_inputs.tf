variable "resource_group_inputs" {
  default = { dev = {
    uksouth = {
      rg_name     = "rg-dev-webapp-uks"
      rg_location = "uksouth"
    }
    ukwest = {
      rg_name     = "rg-dev-webapp-ukw"
      rg_location = "ukwest"
    }
    }
    prod = {
      uksouth = {
        rg_name     = "rg-prod-webapp-uks"
        rg_location = "uksouth"
      }
      ukwest = {
        rg_name     = "rg-prod-webapp-ukw"
        rg_location = "ukwest"
      }
  } }
}

variable "keyvault_inputs" {
  default = { dev = {
    kv_name = "kv-dev-keyvault-webapp"
    }
    prod = {
      kv_name = "kv-prod-keyvault-webapp"
  } }
}

variable "mount_volume_inputs" {
  default = { dev = {
    sa_account_replication_type = "ZRS"
    sa_account_tier             = "Standard"
    sa_name                     = "strgdevappservice01"
    fileshare_name              = "assets"
    fileshare_quota             = 50
    }
    prod = {
      sa_account_replication_type = "ZRS"
      sa_account_tier            = "Standard"
      sa_name                    = "strgprodappservice01"
      fileshare_name             = "assets"
      fileshare_quota            = 50
  } }
}
