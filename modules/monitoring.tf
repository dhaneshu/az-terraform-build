resource "azurerm_application_insights" "app_insights" {
  name                = var.monitoring_inputs.app_insights_name
  location            = azurerm_resource_group.rg["uksouth"].location
  resource_group_name = azurerm_resource_group.rg["uksouth"].name

  application_type = "web"

  tags = var.tags
}
