resource_groups = {
  networking_firewall_re1 = {
    name   = "networking-firewall-egress-internet-re1"
    region = "region1"
    tags = { 
      purpose = "egress networking spoke resource group" # replace with purpose
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = "egress"   
    }      
  }
}
