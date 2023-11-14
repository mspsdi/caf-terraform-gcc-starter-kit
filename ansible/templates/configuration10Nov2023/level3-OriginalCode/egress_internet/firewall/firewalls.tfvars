azurerm_firewalls = {
  # ingress firewall
  fw_re1 = {
    name               = "egress-internet"
    resource_group_key = "networking_firewall_re1"
    # add the resource group name to resolve the issue of subnet rg different from firewall rg
    # TODO: subnet resource group name - input as variable for code generation
    # ** firewall MUST be in the same resource group as VNet and Subnet AzureFirewallSubnet
    resource_group_name = "gcci-platform" # the resource group name of the subnet    

    subnet_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-egress-internet/subnets/AzureFirewallSubnet"
    sku_tier = "Basic"
    firewall_policy_key = "policy1"    
    public_ips = {
      ip_configuration = {
        name = "public-ip"
        public_ip_key = "firewall_re1"
        vnet_key = "vnet_hub_internet_egress_re1"
        subnet_key = "AzureFirewallSubnet"
        lz_key = "networking_hub_internet"    
        #                   subnet_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-egress-internet/subnets/AzureFirewallSubnet"
      }
    }

    # management subnet is required for force tunneling
    management_ip_configuration = {
     management_ip_configuration = {
       name = "management-ip"
       public_ip_key = "firewall_mgmt_re1"
        vnet_key = "vnet_hub_internet_egress_re1"
        subnet_key = "AzureFirewallSubnet"
        lz_key = "networking_hub_internet"    
        #       subnet_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-egress-internet/subnets/AzureFirewallManagementSubnet"
     }
    }    

    # 27 Sep 2022 - add diagnostic_profiles and tags
    tags = { 
      purpose = "ingress networking spoke resource group" # replace with purpose
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = "egress"          
    } 

    diagnostic_profiles = {
      central_logs_region = {
        definition_key   = "firewall"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }


  }

}

