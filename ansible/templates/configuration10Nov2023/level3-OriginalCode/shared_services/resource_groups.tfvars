resource_groups = {
  ops_rg_re1 = {
    name   = "shared-services-re1"
    region = "region1"
    tags = { 
      purpose = "shared services resource groups" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = ""        
    }   
  }
}