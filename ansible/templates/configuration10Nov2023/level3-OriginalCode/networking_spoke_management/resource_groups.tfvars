
resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  networking_spoke_management_re1 = {
    name   = "networking-spoke-management-re1"

    tags = { 
      purpose = "spoke management resource groups" 
      project-code = "escep" 
      env = "uat" 
      zone = "management"
      tier = ""    
    } 
  }

}


