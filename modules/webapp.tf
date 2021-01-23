
resource "azurerm_app_service_plan" "app_plan" {
  for_each            = var.webapp_service_plan_inputs
  name                = each.value.service_plan_name
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  kind                = each.value.service_plan_kind
  reserved            = each.value.service_plan_reserved
  sku {
    tier = each.value.service_plan_tier
    size = each.value.service_plan_size
  }
  tags = var.tags
}

resource "azurerm_app_service" "webapp" {
  for_each            = var.webapp_inputs
  name                = each.value.name
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  app_service_plan_id = azurerm_app_service_plan.app_plan[each.key].id

  app_settings = {
  }

  connection_string {
    name  = "Database"
    type  = "MySql"
    value = "Database=${azurerm_mysql_database.db[each.key].name};Data Source=${random_password.sql[each.key].result}"
  }
  storage_account {
    name         = "solr_mount_${each.key}"
    account_name = azurerm_storage_account.assets_storage.name
    share_name   = azurerm_storage_share.assets_share.name
    access_key   = azurerm_storage_account.assets_storage.primary_access_key
    type         = "AzureFiles"
    mount_path   = "/var/solr"
  }
  site_config {
    always_on        = true
    linux_fx_version = "DOCKER|solr:latest"
  }
  identity {
    type = "SystemAssigned"
  }
  tags       = var.tags
  depends_on = [azurerm_key_vault_access_policy.kv]
}
