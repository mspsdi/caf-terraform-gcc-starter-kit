resource "azurerm_virtual_network" "gcci_vnets" {
  for_each            = var.gcci_virtual_networks
  name                = "${each.value["name"]}${var.random_string}"
  location            = var.location
  resource_group_name = azurerm_resource_group.gcci_resource_groups[each.value["rg_key"]].name
  address_space       = each.value["address_space"]
  dns_servers         = lookup(each.value, "dns_servers", null)

  tags = each.value["tags"]

  depends_on = [
    azurerm_resource_group.gcci_resource_groups
  ]
}

resource "azurerm_virtual_network_peering" "gcci_vnet_peers" {
  for_each                     = var.gcci_vnet_peers
  name                         = "${each.value["name"]}${var.random_string}"
  virtual_network_name         = azurerm_virtual_network.gcci_vnets[each.value["vnet_key"]].name
  remote_virtual_network_id    = azurerm_virtual_network.gcci_vnets[each.value["remote_vnet_key"]].id
  resource_group_name          = azurerm_resource_group.gcci_resource_groups[each.value["rg_key"]].name
  allow_virtual_network_access = lookup(each.value, "allow_virtual_network_access", null)
  allow_forwarded_traffic      = lookup(each.value, "allow_forwarded_traffic", null)
  allow_gateway_transit        = lookup(each.value, "allow_gateway_transit", null)
  use_remote_gateways          = lookup(each.value, "use_remote_gateways", null)

  depends_on = [
    azurerm_virtual_network.gcci_vnets
  ]
}