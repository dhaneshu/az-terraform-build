resource "random_password" "sql" {
  for_each         = var.database_inputs
  length           = 32
  special          = true
  override_special = "_%@"
}



resource "azurerm_key_vault_secret" "db" {
  for_each     = var.database_inputs
  name         = "sql-admin-password-${each.key}"
  value        = random_password.sql[each.key].result
  content_type = "User Name - sqladmin"
  key_vault_id = azurerm_key_vault.kv.id
  depends_on   = [azurerm_key_vault_access_policy.kv]
}


resource "azurerm_mysql_server" "db" {
  for_each            = var.database_inputs
  name                = each.value.mysql_server_name
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name

  administrator_login          = "sqladmin"
  administrator_login_password = azurerm_key_vault_secret.db[each.key].value

  sku_name   = each.value.sku_name
  storage_mb = each.value.storage_mb
  version    = each.value.version

  auto_grow_enabled                 = each.value.auto_grow_enabled
  backup_retention_days             = each.value.backup_retention_days
  geo_redundant_backup_enabled      = each.value.geo_redundant_backup_enabled
  infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled
  public_network_access_enabled     = each.value.public_network_access_enabled
  ssl_enforcement_enabled           = each.value.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced  = each.value.ssl_minimal_tls_version_enforced

  tags       = var.tags
  depends_on = [azurerm_key_vault_access_policy.kv]
}

resource "azurerm_mysql_database" "db" {
  for_each            = var.database_inputs
  name                = each.value.DB_Name
  resource_group_name = azurerm_resource_group.rg[each.key].name
  server_name         = azurerm_mysql_server.db[each.key].name
  charset             = each.value.DB_charset
  collation           = each.value.DB_collation

}
