resource "azurerm_storage_account" "assets_storage" {
  account_replication_type = var.mount_volume_inputs.sa_account_replication_type
  account_tier             = var.mount_volume_inputs.sa_account_tier
  location                 = azurerm_resource_group.rg["uksouth"].location
  name                     = var.mount_volume_inputs.sa_name
  resource_group_name      = azurerm_resource_group.rg["uksouth"].name
  tags                     = var.tags
}

resource "azurerm_storage_share" "assets_share" {
  name                 = var.mount_volume_inputs.fileshare_name
  storage_account_name = azurerm_storage_account.assets_storage.name
  quota                = var.mount_volume_inputs.fileshare_quota
}
