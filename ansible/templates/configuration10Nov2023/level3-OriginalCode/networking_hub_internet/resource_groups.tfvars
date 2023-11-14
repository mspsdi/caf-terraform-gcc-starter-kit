
resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  networking_hub_internet_re1 = {
    name   = "networking-hub-internet-re1"
    # name   = "gcci-platform"

    tags = { 
      purpose = "hub internet resource group" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = ""         
    }  
  }

}


