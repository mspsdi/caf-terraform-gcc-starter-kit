vnets = {

  vnet_hub_intranet_ingress_re1 = { 
    resource_group_key = "networking_hub_intranet_re1"
    region             = "region1"
    vnet = {
      name          = "hub-intranet-ingress-re1"
      address_space = ["10.2.0.0/25"]
    }


    # AzureFirewallSubnet    10.2.0.0/26
    # ApplicationGatewaySubnet 10.2.0.64/27"
    # AzureFirewallSubnet_egress 10.2.1.0/26
    # AzureFirewallMangementSubnet_egress 10.2.1.64/26
    subnets = {

      # begin ingress zone
      AzureFirewallSubnet = {
        name    = "AzureFirewallSubnet" # Must be called AzureFirewallSubnet
        cidr    = ["10.2.0.0/26"] # 64 ips
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-ingress-intranet"

        # }      
      } 
      ApplicationGatewaySubnet = {
        name    = "ingress-agw" 
        cidr    = ["10.2.0.64/27"]  # 23 ips
        nsg_key = "web_nsg"    
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-ingress-intranet"

        # }      
      }   
      # end ingress zone
    }

  }

  vnet_hub_intranet_egress_re1 = { 
    resource_group_key = "networking_hub_intranet_re1"
    region             = "region1"
    vnet = {
      name          = "hub-intranet-egress-re1"
      address_space = ["10.2.1.0/25"]
    }

    subnets = {
    # AzureFirewallSubnet    10.2.0.0/26
    # ApplicationGatewaySubnet 10.2.0.64/27"
    # AzureFirewallSubnet_egress 10.2.1.0/26
    # AzureFirewallMangementSubnet_egress 10.2.1.64/26
      # begin egress zone
      AzureFirewallSubnet_egress = {
        name    = "AzureFirewallSubnet" # Must be called AzureFirewallSubnet
        cidr    = ["10.2.1.0/26"]   # 64 ips
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-egress-intranet"

        # }      
      }  
      AzureFirewallMangementSubnet_egress = {
        name    = "AzureFirewallManagementSubnet" 
        cidr    = ["10.2.1.64/26"]   # 64 ips
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-egress-intranet"

        # }      
      }   
      # end egress zone  
    }




  }

} //vnets