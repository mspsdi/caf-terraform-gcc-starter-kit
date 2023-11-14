private_dns = {



  # cosmos_dns_re1 = {
  #   name               = "documents.azure.com"
  #   resource_group_key = "ops_rg_re1"

  #   vnet_links = {
  #     cosmos_internet_vnet_link = {
  #       name = "cosmos-vnet-link"
  #       registration_enabled = false
  #       vnet_key = "vnet_spoke_internet_re1"        
  #       # virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
  #     }
  #   }

  #   tags = { 
  #     purpose = "internet cosmos private dns" 
  #     project-code = "escep" 
  #     env = "uat" 
  #     zone = "internet"
  #     tier = ""           
  #   } 
  # }

  #   monitoring: 1    
  #   recovery_services_vault: 1 
  #   ampls: 1   
  #   application_insights: 0 # wip
  #   automation: 0          # wip

  backup_dns_re1 = {
    name               = "privatelink.sea.backup.windowsazure.com"
    resource_group_key = "networking_spoke_management_re1"
    vnet_links = {
      vnet_link_project = {
        name               = "backup-vent-link-project"
        vnet_key = "vnet_spoke_internet_re1"  
        lz_key = "networking_spoke_internet"      
        # virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
      }
      vnet_link_mgmt = {
        name               = "backup-vent-link-mgmt"
        vnet_key = "vnet_hub_management_re1"        
        #         virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-management"
      }
    }

    tags = { 
      purpose = "management backup private dns" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = ""            
    } 
  }
  

  # begin ampls dns
  
  monitor_dns_re1  = {
    name               = "privatelink.monitor.azure.com"
    resource_group_key = "networking_spoke_management_re1"
    vnet_links = {
      vnet_link_project = {
        name               = "monitor-vent-link-project"
        vnet_key = "vnet_spoke_internet_re1"  
        lz_key = "networking_spoke_internet"      
        # virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
      }
      vnet_link_mgmt = {
        name               = "monitor-vent-link-mgmt"
        vnet_key = "vnet_hub_management_re1"        
        #         virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-management"
      }

    }
    tags = { 
      purpose = "management monitor private dns" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = ""            
    }     
  }  

  oms_dns_re1 = {
    name               = "privatelink.oms.opinsights.azure.com"
    resource_group_key = "networking_spoke_management_re1"
    vnet_links = {
      vnet_link_project = {
        name               = "oms-vent-link-project"
        vnet_key = "vnet_spoke_internet_re1"  
        lz_key = "networking_spoke_internet"      
        # virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
      }
      vnet_link_mgmt = {
        name               = "oms-vent-link-mgmt"
        vnet_key = "vnet_hub_management_re1"        
        #         virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-management"
      }
    }
    tags = { 
      purpose = "management ampls oms private dns" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = ""            
    }     
  }

  ods_dns_re1 = {
    name               = "privatelink.ods.opinsights.azure.com"
    resource_group_key = "networking_spoke_management_re1"
    vnet_links = {
      vnet_link_project = {
        name               = "ods-vent-link-project"
        vnet_key = "vnet_spoke_internet_re1"  
        lz_key = "networking_spoke_internet"      
        # virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
      }
      vnet_link_mgmt = {
        name               = "ods-vent-link-mgmt"
        vnet_key = "vnet_hub_management_re1"        
        #         virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-management"
      }
    }
    tags = { 
      purpose = "management ampls ods private dns" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = ""            
    }     
  }

  agentsvc_dns_re1 = {
    name               = "privatelink.agentsvc.azure-automation.net"
    resource_group_key = "networking_spoke_management_re1"
    vnet_links = {
      vnet_link_project = {
        name               = "agentsvc-vent-link-project"
        vnet_key = "vnet_spoke_internet_re1"  
        lz_key = "networking_spoke_internet"      
        # virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet"
      }
      vnet_link_mgmt = {
        name               = "agentsvc-vent-link-mgmt"
        vnet_key = "vnet_hub_management_re1"        
        #         virtual_network_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-management"
      }
    }
    tags = { 
      purpose = "management ampls agentsvc private dns" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = ""            
    }     
  }  
    
  # end ampls dns
}