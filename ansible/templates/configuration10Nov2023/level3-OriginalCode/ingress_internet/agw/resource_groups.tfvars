resource_groups = {
  agw_re1 = {
    name = "agw-ingress-internet-re1"           
    region = "region1"    
    tags = { 
      purpose = "internet agw resource group" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = "ingress"           
    }        
  }
}