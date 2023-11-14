
private_dns = {
  dns1 = {
    name               = "rsaf.gov.sg"
    resource_group_key = "networking_hub_intranet_re1"

    records = {
      a_records = {
        aks = {
          name    = "aks-openai"
          ttl     = 3600
          records = ["100.2.0.95"] # TODO: set the aks intranet private ip address
        }
        ingress = {
          name    = "openai"
          ttl     = 3600
          records = ["10.2.0.74"] # TODO: set the agw intranet private ip address
        }        
      }                
    }

    vnet_links = {
      app_internet_vnet_link = {
        name               = "ingress-intranet-vnet"
        # registration_enabled = true
        vnet_ley = "vnet_hub_intranet_ingress_re1"
        # virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-ingress-intranet"
      }    
    }
  }
}