resource_groups = {
  networking_firewall_re1 = {
    name   = "networking-firewall-ingress-intranet-re1"
    region = "region1"
    tags = { 
      purpose = "ingress networking spoke resource group" # replace with purpose
      project-code = "escep" 
      env = "uat" 
      zone = "intranet"
      tier = "ingress"     
    }      
  }
}
