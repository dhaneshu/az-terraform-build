variable "monitoring_inputs" {
  default = {
    dev = {
      app_insights_name = "myappinsight"
    }
    prod = {}
  }
}
