resource "azurerm_log_analytics_workspace" "gcci_log_analytics_workspaces" {
  for_each = var.gcci_log_analytics_workspaces
  name                = "${each.value["name"]}${var.random_string}"
  location            = var.location
  resource_group_name = azurerm_resource_group.gcci_resource_groups[each.value["rg_key"]].name
  sku                 = "PerGB2018" # each.value["sku"] 
  retention_in_days   = 30 # each.value["retention_in_days"]
  
  tags = each.value["tags"]

  depends_on = [
    azurerm_resource_group.gcci_resource_groups
  ]
}