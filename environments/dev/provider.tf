provider "azurerm" {
  subscription_id = <Subscription_ID>" # Enter Subscription ID
  tenant_id       = "<Tenant ID>" # Enter Tenant ID
  features {}
}

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "<RG_Name>"              # Enter Resource Group name for terraform state file
#     storage_account_name = "<storage_account_name>" # Enter Storage account name, must exist
#     container_name       = "<container_name>"       # Enter your Blob container name, must exist
#     key                  = "<key_name>.tfstate"     # Enter a name for your state file
#     subscription_id      = "<Subscription_ID>"      # Enter Subscription ID
#     tenant_id            = "<Tenant ID>"
#   }
# }
