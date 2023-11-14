public_ip_addresses = {
  agw_pip_re1 = {
    name                    = "agw-re1"
    resource_group_key      = "agw_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    availability_zone       = "1"
    idle_timeout_in_minutes = "4"

    tags = { 
      purpose = "intranet agw public ip address" 
      project-code = "escep" 
      env = "uat" 
      zone = "intranet"
      tier = "ingress"          
    }     

  }
}