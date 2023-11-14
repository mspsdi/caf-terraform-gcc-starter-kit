vnets = {

  # project vnet - internet zone
  vnet_hub_management_re1 = { 
    resource_group_key = "networking_spoke_management_re1"
    region             = "region1"
    vnet = {
      name          = "spoke-management-re1"
      address_space = ["100.3.0.0/24"]
    }


    subnets = {

      # begin management zone
      management_infra_subnet = {
        name    = "infra-management"
        cidr    = ["100.3.0.0/26"] # 64 ips 
        nsg_key = "jumpbox"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-management"
        # }      
      } 

      management_security_subnet = {
        name    = "security-management"
        cidr    = ["100.3.0.64/26"] # 64 ips 
        nsg_key = "jumpbox"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-management"
        # }      
      }  

      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" # Must be called AzureBastionSubnet
        cidr    = ["100.3.0.128/26"] # 64 ips
        nsg_key = "azure_bastion_nsg"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-management"
        # }      
      }  
      # end management zone
    }


  }

} //vnets
