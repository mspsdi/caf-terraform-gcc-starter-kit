keyvaults = {
  certificates = {
    name               = "certs_internet"
    resource_group_key = "agw_re1"
    sku_name           = "standard"

    enabled_for_deployment = true

    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

    # 27 Sep 2022 - add in diagnostic_profiles and tags
    diagnostic_profiles = {
      operations = {
        definition_key   = "keyvault"
        destination_type = "log_analytics" # or destination_type = "event_hub"
        destination_key  = "central_logs"          
      }
    }

    tags = { 
      purpose = "escep keyvaults" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = "ingress"       
    }  

  }
}

keyvault_access_policies = {
  certificates = {
    agw1_keyvault_demo_certs = {
      managed_identity_key    = "agw1_keyvault_demo_certs"
      certificate_permissions = ["Get"]
      secret_permissions      = ["Get"]
    }
  }
}