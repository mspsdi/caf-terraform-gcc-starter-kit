landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level3"
  key                 = "networking_vnets" 
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate" # set to launchpad tfstate name
    }        
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  networking_vnets_re1 = {
    name   = "gcci-platform"
    tags = { 
      purpose = "hub internet resource group" 
      project-code = "osscuat" 
      env = "sandpit" 
      zone = "internet"
      tier = ""         
    }  
  }
  agency_law_re1 = {
    name   = "gcci-agency-law"
    tags = { 
      purpose = "hub internet resource group" 
      project-code = "osscuat" 
      env = "sandpit" 
      zone = "internet"
      tier = ""         
    }  
  }  
}

diagnostic_log_analytics = {
  central_logs_region1 = {
    region             = "region1"
    name               = "gcci-agency-workspace" # law resource name: {{prefix}}-log-agency-law
    resource_group_key = "agency_law_re1"
  }
}

vnets = {

  # hub-internet-ingress  
  vnet_hub_internet_ingress_re1 = { 
    resource_group_key = "networking_vnets_re1"
    region             = "region1"
    vnet = {
      name          = "hub-internet-ingress-re1"
      address_space = ["100.127.0.0/24"] # ["100.1.0.0/24"]
    }
  }

  # hub-internet-egress
  vnet_hub_internet_egress_re1 = { 
    resource_group_key = "networking_vnets_re1"
    region             = "region1"
    vnet = {
      name          = "hub-internet-egress-re1"
      address_space = ["100.127.1.0/24"] # ["100.1.1.0/24"]
    }
  }

  # hub-intranet-ingress
  vnet_hub_intranet_ingress_re1 = { 
    resource_group_key = "networking_vnets_re1"
    region             = "region1"
    vnet = {
      name          = "hub-intranet-ingress-re1"
      address_space = ["10.127.0.0/25"] # ["10.2.0.0/25"]
    }
  }

  # hub-intranet-egress
  vnet_hub_intranet_egress_re1 = { 
    resource_group_key = "networking_vnets_re1"
    region             = "region1"
    vnet = {
      name          = "hub-intranet-egress-re1"
      address_space = ["10.127.1.0/25"] #["10.2.1.0/25"]
    }  
  }

  # project vnet - internet zone
  vnet_spoke_internet_re1 = { 
    resource_group_key = "networking_vnets_re1"
    region             = "region1"
    vnet = {
      name          = "spoke-internet-re1"
      address_space = ["100.64.0.0/23"] # ["100.2.0.0/24"]
    }
  }

  # management vnet
  vnet_hub_management_re1 = { 
    resource_group_key = "networking_vnets_re1"
    region             = "region1"
    vnet = {
      name          = "spoke-management-re1"
      address_space = ["100.127.3.0/24"] # ["100.3.0.0/24"]
    }
  }   

  # devops vnet
  vnet_spoke_devops_re1 = { 
    resource_group_key = "networking_vnets_re1"
    region             = "region1"
    vnet = {
      name          = "spoke-devops-re1"
      address_space = ["100.127.4.0/24"] # ["100.4.0.0/24"]
    }
  }

} //vnets






