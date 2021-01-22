variable "tags" {
  type = map(any)
}
variable "resource_group_inputs" {
  type = map(any)
}

variable "keyvault_inputs" {
  type = map(any)

}

variable "mount_volume_inputs" {
  type = map(any)
}


variable "database_inputs" {
  type = map(any)
}

variable "monitoring_inputs" {
  type = map(any)
}

variable "network_inputs" {
  type = map(any)
}

variable "webapp_service_plan_inputs" {
  type = map(any)
}

variable "webapp_inputs" {
  type = map(any)
}
