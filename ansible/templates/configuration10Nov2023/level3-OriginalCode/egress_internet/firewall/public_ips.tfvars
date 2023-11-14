public_ip_addresses = {
  firewall_re1 = {
    name                    = "fw-egress-pip1"
    resource_group_key      = "networking_firewall_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }

  firewall_mgmt_re1 = {
    name                    = "fw-egress-pip2"
    resource_group_key      = "networking_firewall_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }

}
