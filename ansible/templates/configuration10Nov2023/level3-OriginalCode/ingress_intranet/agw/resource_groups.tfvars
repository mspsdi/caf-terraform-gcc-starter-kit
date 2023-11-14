resource_groups = {
  agw_re1 = {
    name = "agw-ingress-intranet-re1"           
    region = "region1"    
    tags = { 
      purpose = "intranet agw resource group" 
      project-code = "escep" 
      env = "uat" 
      zone = "intranet"
      tier = "ingress"          
    }        
  }
}