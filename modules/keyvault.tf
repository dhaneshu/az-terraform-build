resource "azurerm_key_vault" "kv" {
  name                        = module.vars.keyvault_inputs.kv_name
  location                    = azurerm_resource_group.rg["uksouth"].location
  resource_group_name         = azurerm_resource_group.rg["uksouth"].name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
  tags     = module.vars.tags
}

resource "azurerm_key_vault_access_policy" "kv" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "get",
    "set",
    "purge",
    "delete",
    "recover",
    "restore",
    "list"

  ]
}
