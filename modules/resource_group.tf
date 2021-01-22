resource "azurerm_resource_group" "rg" {
  for_each = var.resource_group_inputs
  name     = each.value.rg_name
  location = each.value.rg_location
  tags     = var.tags
}
