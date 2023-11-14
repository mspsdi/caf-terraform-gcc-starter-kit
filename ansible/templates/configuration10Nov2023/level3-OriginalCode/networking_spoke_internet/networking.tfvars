vnets = {

  # project vnet - internet zone
  vnet_spoke_internet_re1 = { 
    resource_group_key = "networking_spoke_internet_re1"
    region             = "region1"
    vnet = {
      name          = "spoke-internet-re1"
      address_space = ["100.2.0.0/24"]
    }

    subnets = {

  #     aks_nodepool_system = {
  #       name            = "aks_nodepool_system"
  #       cidr            = ["10.100.80.0/24"]
  #       nsg_key         = "azure_kubernetes_cluster_nsg"
  #       route_table_key = "default_to_firewall_re1"
  #     }

      # private segment
      app_internet_subnet = {
        name    = "app-internet"
        cidr    = ["100.2.0.0/27"]
        nsg_key = "app_nsg"
        # route_table_key = "default_to_firewall_re1"    # enable this if route_tables is used
        enforce_private_link_endpoint_network_policies = "true"    
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
        # }    
      }  
      db_internet_subnet = {
        name    = "db-internet"
        cidr    = ["100.2.0.32/27"]
        nsg_key = "db_nsg"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
        enforce_private_link_endpoint_network_policies = "true"   
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
        # }
      }  

      # websubnet, service_subnet, chatgptsubnet, aisubnet,  applicaitongatewaysubnet

      web_internet_subnet = {
        name    = "web-internet"
        cidr    = ["100.2.0.64/27"]
        nsg_key = "web_nsg"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
        enforce_private_link_endpoint_network_policies = "true"   
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
        # }
      }  

      service_internet_subnet = {
        name    = "service-internet"
        cidr    = ["100.2.0.96/27"]
        nsg_key = "service_nsg"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
        enforce_private_link_endpoint_network_policies = "true"   
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
        # }
      } 

      chatgpt_internet_subnet = {
        name    = "chatgpt-internet"
        cidr    = ["100.2.0.128/27"]
        nsg_key = "chatgpt_nsg"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
        enforce_private_link_endpoint_network_policies = "true"  
        delegation = {
          name               = "container_groups"
          service_delegation = "Microsoft.ContainerInstance/containerGroups" # Microsoft.Web/serverFarms"
          actions            = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }      
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
        # }
      } 

      ai_internet_subnet = {
        name    = "ai-internet"
        cidr    = ["100.2.0.160/27"]
        nsg_key = "ai_nsg"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
        enforce_private_link_endpoint_network_policies = "true"   
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
        # }
      }   

      applicaitongateway_internet_subnet = {
        name    = "applicationgateway-internet"
        cidr    = ["100.2.0.192/27"]
        nsg_key = "app_nsg" # "applicationgateway_nsg"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
        enforce_private_link_endpoint_network_policies = "true"   
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
        # }
      }  

      functionapps_internet_subnet = {
        name    = "function-apps-internet"
        cidr    = ["100.2.0.224/27"]
        nsg_key = "functionapps_nsg"
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
        enforce_private_link_endpoint_network_policies = "true"   
        # TODO: add Delegated function - Delegated to "Microsoft.Web/serverFarms"
        delegation = {
          name               = "functions"
          service_delegation = "Microsoft.Web/serverFarms"
          actions            = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }    
        # vnet = {
        #   id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
        # }
      }

      # end private segment
    }



  }

  # vnet_aks_re1 = {
  #   resource_group_key = "aks_spoke_re1"
  #   region             = "region1"
  #   vnet = {
  #     name          = "aks"
  #     address_space = ["10.100.80.0/22"]
  #   }
  #   subnets = {
  #     aks_nodepool_system = {
  #       name            = "aks_nodepool_system"
  #       cidr            = ["10.100.80.0/24"]
  #       nsg_key         = "azure_kubernetes_cluster_nsg"
  #       route_table_key = "default_to_firewall_re1"
  #     }
  #     aks_nodepool_user1 = {
  #       name            = "aks_nodepool_user1"
  #       cidr            = ["10.100.81.0/24"]
  #       nsg_key         = "azure_kubernetes_cluster_nsg"
  #       route_table_key = "default_to_firewall_re1"
  #     }
  #     aks_ingress = {
  #       name            = "aks_ingress"
  #       cidr            = ["10.100.82.0/24"]
  #       nsg_key         = "azure_kubernetes_cluster_nsg"
  #       route_table_key = "default_to_firewall_re1"
  #     }
  #     jumpbox = {
  #       name            = "jumpbox"
  #       cidr            = ["10.100.83.64/28"]
  #       nsg_key         = "azure_kubernetes_cluster_nsg"
  #       route_table_key = "default_to_firewall_re1"
  #     }
  #     private_endpoints = {
  #       name                                           = "private_endpoints"
  #       cidr                                           = ["10.100.83.0/27"]
  #       enforce_private_link_endpoint_network_policies = true
  #     }
  #     AzureBastionSubnet = {
  #       name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
  #       cidr    = ["10.100.83.32/27"]
  #       nsg_key = "azure_bastion_nsg"
  #     }
  #     application_gateway = {
  #       name    = "agw"
  #       cidr    = ["10.100.83.96/27"]
  #       nsg_key = "application_gateway"
  #     }
  #   } //subnets


  #   specialsubnets = {
  #     AzureFirewallSubnet = {
  #       name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
  #       cidr = ["10.100.83.128/26"]
  #     }
  #     GatewaySubnet = {
  #       name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
  #       cidr = ["10.100.83.224/27"]
  #     }
  #   } //specialsubnets
  # }


} //vnets
