resource "random_string" "random_suffix_string" {
  length  = var.random_string_length
  special = false
  upper   = false
  lower   = true
  numeric = false
}

# This module generates the gcci scaffolding of vnets, log analytic workspace, etc. based on the variables' values
module "gcci_model" {
  source = "./modules/scaffolding"

  location      = var.location
  random_string = "" # TODO: remove random string for development testing
  # random_string = random_string.random_suffix_string.result

  gcci_resource_groups  = var.gcci_resource_groups
  gcci_virtual_networks = var.gcci_virtual_networks
  gcci_vnet_peers       = var.gcci_vnet_peers
  gcci_log_analytics_workspaces       = var.gcci_log_analytics_workspaces

  depends_on = [
    random_string.random_suffix_string
  ]
}