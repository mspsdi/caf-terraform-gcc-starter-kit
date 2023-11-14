managed_identities = {
  agw1_keyvault_demo_certs = {
    name               = "agw1-certs-internet-msi"
    resource_group_key = "agw_re1"

    tags = { 
      purpose = "internet agw managed identity" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = "ingress"           
    } 

  }
}
