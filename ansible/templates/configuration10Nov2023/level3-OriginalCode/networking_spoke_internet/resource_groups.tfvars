
resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  networking_spoke_internet_re1 = {
    name   = "networking-spoke-internet-re1"

    tags = { 
      purpose = "spoke internet resource group" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = ""          
    }  
  }

}


