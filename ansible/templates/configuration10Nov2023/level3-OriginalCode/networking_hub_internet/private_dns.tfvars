
private_dns = {
  dns1 = {
    name               = "internet.rsaf.gov.sg"
    resource_group_key = "networking_hub_internet_re1"

    records = {
      a_records = {
        aks = {
          name    = "aks-openai" # e.g. aks-demoapp1
          ttl     = 3600
          records = ["100.2.0.95"] # TODO: set the aks internet private ip address
        }
        ingress = {
          name    = "openai" # e.g. demoapp1
          ttl     = 3600
          records = ["100.2.0.74"] # TODO: set the agw internet private ip address
        }        
      }                 
    }

    vnet_links = {
      ingress_internet_vnet_link = {
        name = "ingress-internet-vnet"
        vnet_key = "vnet_hub_internet_ingress_re1"
      }
    }

    # vnet_links = {
    #   app_internet_vnet_link = {
    #     name               = "ingress-internet-vnet"
    #     registration_enabled = false
    #     vnet_key = "vnet_hub_internet_ingress_re1"  
    #     # lz_key = "vnet_spoke_internet_re1"            
    #     # virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-ingress-internet"
    #   }    
    # }
  }
}