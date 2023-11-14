
resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  networking_spoke_devops_re1 = {
    name   = "networking-spoke-devops-re1"

    tags = { 
      purpose = "spoke devops resource groups" 
      project-code = "escep" 
      env = "uat" 
      zone = "devops"
      tier = ""        
    } 
  }

}


