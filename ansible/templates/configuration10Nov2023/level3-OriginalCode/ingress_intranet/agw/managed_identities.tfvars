managed_identities = {
  agw1_keyvault_demo_certs = {
    name               = "agw1-certs-intranet-msi"
    resource_group_key = "agw_re1"

    tags = { 
      purpose = "intranet agw managed identity" 
      project-code = "escep" 
      env = "uat" 
      zone = "intranet"
      tier = "ingress"          
    } 

  }
}
