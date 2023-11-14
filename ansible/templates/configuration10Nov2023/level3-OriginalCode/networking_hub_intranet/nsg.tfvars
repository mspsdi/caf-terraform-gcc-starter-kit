#
# Definition of the networking security groups
#
network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {
    version            = 1
    resource_group_key = "networking_hub_intranet_re1"
    name               = "empty"
    nsg = []
  }
  # agw
  web_nsg = {
    version            = 1
    resource_group_key = "networking_hub_intranet_re1"
    name               = "web"    
    tags = { 
      purpose = "web tier network security group" 
      project-code = "cep" 
      env = "uat" 
      zone = "intranet"         
    }    
    # flow_logs = {
    #   name    = "web-nsg-intranet" 
    #   version = 2
    #   enabled = true
    #   storage_account = {
    #     storage_account_destination = "all_regions" # refer to value in shared services diagnostic_storage_accounts storage all_regions 
    #     retention = {
    #       enabled = true
    #       days    = 365
    #     }
    #   }
    # }    
    nsg = [

      # https://learn.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure
      # Network security groups (NSGs) are supported on Application Gateway. But there are some restrictions:
      # - You must allow incoming Internet traffic on TCP ports 65503-65534 for the Application Gateway v1 SKU, and TCP ports 65200-65535 for the v2 SKU with the destination subnet as Any and source as GatewayManager service tag. This port range is required for Azure infrastructure communication. These ports are protected (locked down) by Azure certificates. External entities, including the customers of those gateways, can't communicate on these endpoints.
      # - Outbound Internet connectivity can't be blocked. Default outbound rules in the NSG allow Internet connectivity. We recommend that you:
      #     Don't remove the default outbound rules.
      #     Don't create other outbound rules that deny any outbound connectivity.
      # - Traffic from the AzureLoadBalancer tag with the destination subnet as Any must be allowed.

      # do not change      
      # source Internet destination Any : source MUST be Internet and destination MUST be *
      {
        name                       = "Inbound-AGW-management"
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "65200-65535"
        source_address_prefix      = "GatewayManager" # MUST be Internet
        destination_address_prefix = "*" # MUST be *        
      }, 
      # do not change
      # Source AzureLoadBalancer destination Any
      {
        name                       = "Inbound-AzureLoadBalancer-management"
        priority                   = "110"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "VirtualNetwork"
      },         
      # do not change
      # inbound https 443 management infra "100.3.0.0/26" > web "10.2.0.64/27"          
      {
        name                       = "Inbound-HTTPS-management"
        priority                   = "120"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "100.3.0.0/26"
        destination_address_prefix = "10.2.0.64/27"
      }, 
      # do not change      
      # inbound http 80 management infra "100.3.0.0/26" > web "10.2.0.64/27"          
      {
        name                       = "Inbound-HTTP-management"
        priority                   = "200"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "80-82"
        source_address_prefix      = "100.3.0.0/26"
        destination_address_prefix = "10.2.0.64/27"
      },   
      # do not change            
      # inbound ssh 22 management bastion "100.3.0.128/26" > web "10.2.0.64/27"          
      {
        name                       = "Inbound-SSH-management"
        priority                   = "210"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "100.3.0.128/26"
        destination_address_prefix = "10.2.0.64/27"
      },    
    # end management inbound        
    # begin web inbound   
      # inbound https 443 ingress "10.2.0.0/26" > web "10.2.0.64/27"      
      {
        name                       = "Inbound-HTTPS-ingress"
        priority                   = "220"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "10.2.0.0/26"
        destination_address_prefix = "10.2.0.64/27"
      },
      # inbound http 80-82 ingress "10.2.0.0/26" > web "10.2.0.64/27"       
      {
        name                       = "Inbound-HTTP-ingress"
        priority                   = "230"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "80-82"
        source_address_prefix      = "10.2.0.0/26"
        destination_address_prefix = "10.2.0.64/27"
      }, 
      # inbound http 8080-8082 ingress "10.2.0.0/26" > web "10.2.0.64/27"       
      {
        name                       = "Inbound-HTTP-8080-ingress"
        priority                   = "240"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "8080-8082"
        source_address_prefix      = "10.2.0.0/26"
        destination_address_prefix = "10.2.0.64/27"
      },  
      # # custom deny all Inbound
      # {
      #   name                       = "Custom-Deny-All-Inbound"
      #   priority                   = "4000"
      #   direction                  = "Inbound"
      #   access                     = "Deny"
      #   protocol                   = "*"
      #   source_port_range          = "*"
      #   destination_port_range     = "*"
      #   source_address_prefix      = "*"
      #   destination_address_prefix = "*"
      # },       
    # end web inbound   

    # begin management outbound

      # do not change
      # outbound https 443 AzureMonitor"
      {
        name                       = "out-communication-allow-443-AzureMonitor"
        priority                   = "100"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "10.2.0.64/27"
        destination_address_prefix = "AzureMonitor"
      },
      # do not change
      # # outbound https 443 EventHub"
      # {
      #   name                       = "out-communication-allow-443-EventHub"
      #   priority                   = "110"
      #   direction                  = "Outbound"
      #   access                     = "Allow"
      #   protocol                   = "tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "443"
      #   source_address_prefix      = "10.2.0.64/27"
      #   destination_address_prefix = "EventHub"
      # },  
      # do not change
      # outbound https 443 AzureActiveDirectory"
      {
        name                       = "out-communication-allow-443-AzureActiveDirectory"
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "10.2.0.64/27"
        destination_address_prefix = "AzureActiveDirectory"
      }, 
      # do not change
      # outbound https 443 Storage"
      {
        name                       = "out-communication-allow-443-Storage"
        priority                   = "130"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "10.2.0.64/27"
        destination_address_prefix = "Storage"
      },  
      # do not change
      # outbound https 443 AzureKeyVault.SouthEastAsia"
      {
        name                       = "out-communication-allow-443-AzureKeyVault.SouthEastAsia"
        priority                   = "140"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "10.2.0.64/27"
        destination_address_prefix = "AzureKeyVault.SouthEastAsia"
      }, 
      # do not change
      # outbound https 443 MicrosoftCloudAppSecurity"
      {
        name                       = "out-communication-allow-443-MicrosoftCloudAppSecurity"
        priority                   = "150"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "10.2.0.64/27"
        destination_address_prefix = "MicrosoftCloudAppSecurity"
      },                               
      # do not change
      # outbound https 443 web "10.2.0.64/27" > management infra "100.3.0.0/26"
      {
        name                       = "out-communication-allow-443-management"
        priority                   = "160"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "10.2.0.64/27"
        destination_address_prefix = "100.3.0.0/26"
      },
      
    # end management outbound   
    # begin web outbound
      # outbound https 443 web "10.2.0.64/27" > app "100.2.0.0/27"
      {
        name                       = "out-communication-allow-443-app"
        priority                   = "200"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "10.2.0.64/27"
        destination_address_prefix = "100.2.0.0/27"
      },
      # outbound http 8080 web "10.2.0.64/27" > app "100.2.0.0/27"
      {
        name                       = "out-communication-allow-8080-app"
        priority                   = "210"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "10.2.0.64/27"
        destination_address_prefix = "100.2.0.0/27"
      }, 
      # outbound http 80-82 web "10.2.0.64/27" > app "100.2.0.0/27"
      {
        name                       = "out-communication-allow-80-app"
        priority                   = "220"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "80-82"
        source_address_prefix      = "10.2.0.64/27"
        destination_address_prefix = "100.2.0.0/27"
      }, 
      # custom deny all outbound - only valid if private preview is enabled      
      # {
      #   name                       = "custom-deny-all-outbound"
      #   priority                   = "4000"
      #   direction                  = "Outbound"
      #   access                     = "Deny"
      #   protocol                   = "tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "*"
      #   source_address_prefix      = "*"
      #   destination_address_prefix = "*"
      # },           
      # end web outbound 
   
    ]
  }

}
