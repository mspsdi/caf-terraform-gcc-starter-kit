private_dns = {

  blob_dns_re1 = {
    name               = "privatelink.blob.core.windows.net"
    resource_group_key = "storage_accounts_re1"
    
    vnet_links = {
      # db_ingress_vnet_link = {
      #   name                 = "db-ingress-vnet"
      #   registration_enabled = false
      #   virtual_network_id   = "/subscriptions/{{subscription_id}}/resourceGroups/{{resource_group_name}}/providers/Microsoft.Network/virtualNetworks/{{ingress_egress_vnet_name_ingress_internet}}"
      # }
      db_internet_vnet_link = {
        name                 = "db-internet-vnet"
        registration_enabled = false
        virtual_network_id   = "/subscriptions/{{subscription_id}}/resourceGroups/{{resource_group_name}}/providers/Microsoft.Network/virtualNetworks/{{internet_vnet_name}}"
      }
      db_management_vnet_link = {
        name                 = "db-management-vnet"
        registration_enabled = false
        virtual_network_id   = "/subscriptions/{{subscription_id}}/resourceGroups/{{resource_group_name}}/providers/Microsoft.Network/virtualNetworks/{{management_vnet_name}}"
      }
    }

    tags = { 
      purpose = "{{zone_code}} storage account private dns" 
      project-code = "{{project_code}}" 
      env = "{{caf_environment}}" 
      zone = "{{zone_code}}"
      tier = "{{tier_code}}"          
    } 

  }

}
