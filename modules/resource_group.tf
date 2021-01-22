resource "azurerm_resource_group" "rg" {
  for_each = module.vars.resource_group_inputs
  name     = each.value.rg_name
  location = each.value.rg_location
  tags     = module.vars.tags
}

# resource "azurerm_resource_group" "network" {
#   name     = "network-rg"
#   location = "uksouth"
#   tags     = module.vars.tags
# }
