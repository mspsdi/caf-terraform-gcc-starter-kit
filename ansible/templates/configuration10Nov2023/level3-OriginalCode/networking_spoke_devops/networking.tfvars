vnets = {

  # project vnet - internet zone
  vnet_spoke_devops_re1 = { 
    resource_group_key = "networking_spoke_devops_re1"
    region             = "region1"
    vnet = {
      name          = "spoke-devops-re1"
      address_space = ["100.4.0.0/24"]
    }


    subnets = {

      # begin devops zone
      devops_runner_subnet = {
        name    = "runner-devops"
        cidr    = ["100.4.0.16/28"]  # 16 ips
        nsg_key = "runner_nsg"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]   
        delegation = {
          name               = "container_groups"
          service_delegation = "Microsoft.ContainerInstance/containerGroups" # Microsoft.Web/serverFarms"
          actions            = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }  
        # service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
        enforce_private_link_endpoint_network_policies = "true"         
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-devops"
        # }      
      }  
      GatewaySubnet = {
        name    = "GatewaySubnet"
        cidr    = ["100.4.0.0/28"]  # 16 ips
        # nsg_key = "empty_nsg"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]   
        enforce_private_link_endpoint_network_policies = "true"         
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-devops"
        # }      
      }    
      # end devops zone
    }



  }

} //vnets
