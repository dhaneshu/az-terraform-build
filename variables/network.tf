variable "network_inputs" {
  default = { dev = {
    uksouth = {
      vnet_name                             = "vnet-dev-uks"
      vnet_address_space                    = ["10.0.0.0/16"]
      integrationsubnet_name                = "integrationsubnet"
      integrationsubnet_address_prefixes    = ["10.0.1.0/24"]
      endpointsubnetsubnet_name             = "endpointsubnet"
      endpointsubnetsubnet_address_prefixes = ["10.0.2.0/24"]
    }
    ukwest = {
      vnet_name                             = "vnet-dev-ukw"
      vnet_address_space                    = ["10.0.0.0/16"]
      integrationsubnet_name                = "integrationsubnet"
      integrationsubnet_address_prefixes    = ["10.0.1.0/24"]
      endpointsubnetsubnet_name             = "endpointsubnet"
      endpointsubnetsubnet_address_prefixes = ["10.0.2.0/24"]
    }
    }
    prod = {
      uksouth = {}
      ukwest  = {}
  } }
}
