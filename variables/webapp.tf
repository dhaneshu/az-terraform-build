variable "webapp_service_plan_inputs" {
  default = { dev = {
    uksouth = {
      service_plan_name     = "my-appserviceplan-uks"
      service_plan_kind     = "Linux"
      service_plan_reserved = true
      service_plan_tier     = "Standard"
      service_plan_size     = "S1"
    }
    ukwest = {
      service_plan_name     = "my-appserviceplan-ukw"
      service_plan_kind     = "Linux"
      service_plan_reserved = true
      service_plan_tier     = "Standard"
      service_plan_size     = "S1"
    }
    }
    prod = {
      uksouth = {}
      ukwest  = {}
  } }
}


variable "webapp_inputs" {
  default = { dev = {
    uksouth = {
      name = "webapp-dev-uks"
    }
    ukwest = {
      name = "webapp-dev-uks"
    }
    }
    prod = {
      uksouth = {
        name = "webapp-prod-uks"
      }
      ukwest = {
        name = "webapp-prod-uks"
      }
  } }
}
