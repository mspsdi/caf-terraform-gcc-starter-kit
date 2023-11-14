vnets = {

  # ingress/egress vnet - ingress/egress zone (dmz zone)
  vnet_hub_ingress_re1 = { 
    resource_group_key = "vnet_rg_re1"
    region             = "region1"
    vnet = {
      name          = "hub-ingress-re1"
      address_space = ["100.1.0.0/24"]
    }
  }

  vnet_hub_egress_re1 = { 
    resource_group_key = "vnet_rg_re1"
    region             = "region1"
    vnet = {
      name          = "hub-egress-re1"
      address_space = ["100.1.1.0/24"]
    }
  }  

  # project vnet - internet zone
  vnet_spoke_internet_re1 = { 
    resource_group_key = "vnet_rg_re1"
    region             = "region1"
    vnet = {
      name          = "spoke-internet-re1"
      address_space = ["100.2.0.0/24"]
    }
  }

  # # project vnet - intranet zone
  # vnet_spoke_intranet_re1 = { 
  #   resource_group_key = "vnet_rg_re1"
  #   region             = "region1"
  #   vnet = {
  #     name          = "spoke-intranet-re1"
  #     address_space = ["10.0.0.0/20"]
  #   }
  # }

  # management vnet - management zone
  vnet_hub_management_re1 = { 
    resource_group_key = "vnet_rg_re1"
    region             = "region1"
    vnet = {
      name          = "spoke-management-re1"
      address_space = ["100.3.0.0/24"]
    }
  }

  # devops vnet - devops zone
  vnet_spoke_devops_re1 = { 
    resource_group_key = "vnet_rg_re1"
    region             = "region1"
    vnet = {
      name          = "spoke-devops-re1"
      address_space = ["100.4.0.0/24"]
    }
  }  

}
