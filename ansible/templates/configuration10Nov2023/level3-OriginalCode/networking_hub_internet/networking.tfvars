vnets = {

  vnet_hub_internet_ingress_re1 = { 
    resource_group_key = "networking_hub_internet_re1"
    region             = "region1"
    vnet = {
      name          = "hub-internet-ingress-re1"
      address_space = ["100.1.0.0/24"]
    }

    # AzureFirewallSubnet 100.1.0.0/26
    # ApplicationGatewaySubnet 100.1.0.64/26
    # AzureFirewallSubnet_egress 100.1.1.0/26
    subnets = {

      # begin ingress zone
      AzureFirewallSubnet = {
        name    = "AzureFirewallSubnet" # Must be called AzureFirewallSubnet
        cidr    = ["100.1.0.0/26"] # 64 ips
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-ingress-internet"

        # }      
      } 
      ApplicationGatewaySubnet = {
        name    = "ingress-agw" 
        cidr    = ["100.1.0.64/26"]  # 64 ips
        nsg_key = "web_nsg"    
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-ingress-internet"

        # }      
      }    
      # end ingress zone

    }



  }

  vnet_hub_internet_egress_re1 = { 
    resource_group_key = "networking_hub_internet_re1"
    region             = "region1"
    vnet = {
      name          = "hub-internet-egress-re1"
      address_space = ["100.1.1.0/24"]
    }


    # AzureFirewallSubnet 100.1.0.0/26
    # ApplicationGatewaySubnet 100.1.0.64/26
    # AzureFirewallSubnet_egress 100.1.1.0/26
    subnets = {

      # begin egress zone
      AzureFirewallSubnet_egress = {
        name    = "AzureFirewallSubnet" # Must be called AzureFirewallSubnet
        cidr    = ["100.1.1.0/26"]   # 64 ips
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-egress-internet"

        # }      
      }  
      AzureFirewallMangementSubnet_egress = {
        name    = "AzureFirewallManagementSubnet" 
        cidr    = ["100.1.1.64/26"]   # 64 ips
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-egress-internet"

        # }      
      }   
      # end egress zone  
    }

  }

} //vnets
