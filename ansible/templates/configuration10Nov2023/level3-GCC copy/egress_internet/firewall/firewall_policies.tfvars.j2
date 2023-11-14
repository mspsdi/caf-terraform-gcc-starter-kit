# reference: https://learn.microsoft.com/en-us/azure/aks/limit-egress-traffic

azurerm_firewall_policies = {
  # for ingress firewall
  policy1 = {
    name               = "firewall-policy-egress-internet"
    resource_group_key = "networking_firewall_re1"
    region             = "region1"
    sku                = "Basic" # "Premium"
    
    # # Required if you want to use Network rules with FQDNs
    # dns = {
    #   proxy_enabled = true
    # }

    # threat_intelligence_mode = "Alert"

    #   threat_intelligence_allowlist = {
    #     ip_addresses = []
    #     fqdns        = []
    #   }

    # intrusion_detection = {
    #   mode                = "Alert"
    #     signature_overrides = {
    #       id    = ""
    #       state = ""
    #     }
    #     traffic_bypass      = {
    #       name                  = ""
    #       protocol              = ""
    #       description           = ""
    #       destination_addresses = ""
    #       destination_ip_groups = ""
    #       destination_ports     = ""
    #       source_addresses      = ""
    #       source_ip_groups      = ""
    #     }
    # }
  }
}

azurerm_firewall_policy_rule_collection_groups = {
  group1 = {
    firewall_policy_key = "policy1"
    name                = "egress-fwpolicy-rcg"
    priority            = 500

    # The application rule covers all needed FQDNs accessible through TCP port 443 and port 80.
    application_rule_collections = {
      rule1 = { # dummy example
        name     = "app_rule_collection1"
        priority = 500
        action   = "Deny"
        rules = {
          rule1 = {
            name = "app_rule_collection1_rule1"
            protocols = {
              1 = {
                type = "Http"
                port = 80
              }
              2 = {
                type = "Https"
                port = 443
              }
            }
            source_addresses  = ["10.0.0.1"]
            destination_fqdns = ["*.microsoft.com"]
          }
        }
      }
      aks = {
        name     = "app-rule-collection1-aks"
        priority = 600
        action   = "Allow"
        rules = {
          aks = {
            name = "app-rule-collection1-aks"
            protocols = {
              1 = {
                type = "Http"
                port = 80
              }
              2 = {
                type = "Https"
                port = 443
              }
            }
            # source_addresses  = ["10.0.0.1"]
            source_ip_groups_keys = [
              "aks_ip_group1"
            ]            
            # destination_fqdns = ["*.microsoft.com"]
            destination_fqdn_tags = [ 
              "AzureKubernetesService"
            ]           
          }
        }
      }        
      packages = {
        name     = "packages"
        action   = "Allow"
        priority = 110
        rules = {
          ubuntu = {
            name = "ubuntu"
            # source_addresses = [
            #   "*",
            # ]
            source_ip_groups_keys = [
              "aks_ip_group1"
            ]
            destination_fqdns = [
              "security.ubuntu.com",
              "azure.archive.ubuntu.com",
              "archive.ubuntu.com",
              "changelogs.ubuntu.com",
            ]
            protocols = {
              https = {
                port = "443"
                type = "Https"
              }
              http = {
                port = "80"
                type = "Http"
              }
            }
          },
          docker = {
            name = "docker"
            # source_addresses = [
            #   "*",
            # ]
            source_ip_groups_keys = [
              "aks_ip_group1"
            ]
            destination_fqdns = [
              "download.docker.com", # Docker
              "*.docker.io",         # Docker images
              "*.docker.com"         # Docker registry
            ]
            protocols = {
              http = {
                port = "443"
                type = "Https"
              }
            }
          },
          tools = {
            name = "tools"
            # source_addresses = [
            #   "*",
            # ]
            source_ip_groups_keys = [
              "aks_ip_group1"
            ]
            destination_fqdns = [
              "packages.microsoft.com",
              "azurecliprod.blob.core.windows.net", # Azure cli
              "packages.cloud.google.com",          # kubectl
              "apt.kubernetes.io",                  # Ubuntu packages for kubectl
              "*.snapcraft.io",                     # snap to install kubectl
            ]
            protocols = {
              http = {
                port = "443"
                type = "Https"
              }
            }
          },
          github = {
            name = "github"
            # source_addresses = [
            #   "*",
            # ]
            source_ip_groups_keys = [
              "aks_ip_group1"
            ]
            destination_fqdns = [
              "api.github.com",
              "ghcr.io",
              "*.ghcr.io",
              "github.com",
              "*.githubusercontent.com",
              "charts.bitnami.com"
            ]
            protocols = {
              http = {
                port = "443"
                type = "Https"
              }
            }
          },
          mcr = {
            name = "mcr"
            # source_addresses = [
            #   "*",
            # ]

            source_ip_groups_keys = [
              "aks_ip_group1"
            ]

            destination_fqdns = [
              "*.data.mcr.microsoft.com",
            ]
            protocols = {
              http = {
                port = "443"
                type = "Https"
              }
            }
          },
        }
      }  

    }


# This section covers three network rules and an application rule you can use to configure on your firewall. You may need to adapt these rules based on your deployment.

# The first network rule allows access to port 9000 via TCP.
# The second network rule allows access to port 1194 and 123 via UDP. If you're deploying to Microsoft Azure operated by 21Vianet, see the [Azure operated by 21Vianet required network rules](./outbound-rules-control-egress.md#microsoft-azure-operated by-21vianet-required-network-rules). Both these rules will only allow traffic destined to the Azure Region CIDR in this article, which is East US.
# The third network rule opens port 123 to ntp.ubuntu.com FQDN via UDP. Adding an FQDN as a network rule is one of the specific features of Azure Firewall, so you'll need to adapt it when using your own options.
# The application rule covers all needed FQDNs accessible through TCP port 443 and port 80.

    network_rule_collections = {
      group1 = { # dummy example
        name     = "network_rule_collection1"
        priority = 400
        action   = "Deny"
        rules = {
          rule1 = {
            name                  = "network_rule_collection1_rule1"
            protocols             = ["TCP", "UDP"]
            source_addresses      = ["10.0.0.1"]
            destination_addresses = ["192.168.1.1", "192.168.1.2"]
            destination_ports     = ["80", "1000-2000"]
          }
        }
      }

      aks = { # aks > firewall > internet (ip address/cidr or service tag)
        name     = "aks"
        action   = "Allow"
        priority = 150
        rules = {
          ntp = {
            name = "ntp"
            # source_addresses = [
            #   "*",
            # ]
            source_ip_groups_keys = [
              "aks_ip_group1"
            ]
            destination_ports = [
              "123",
            ]
            destination_addresses = [
              "*"
            ]
            protocols = [
              "UDP",
            ]
          },
          monitor = {
            name = "monitor"
            # source_addresses = [
            #   "*",
            # ]
            source_ip_groups_keys = [
              "aks_ip_group1"
            ]
            destination_ports = [
              "443",
            ]
            destination_addresses = [
              "AzureMonitor"
            ]
            protocols = [
              "TCP",
            ]
          },
          apiservertcp = {
            name = "apiservertcp"
            # source_addresses = [
            #   "*",
            # ]
            source_ip_groups_keys = [
              "aks_ip_group1"
            ]
            destination_ports = [
              "443", "9000", "22"
            ]
            destination_addresses = [
              "AzureCloud"
            ]
            protocols = [
              "TCP",
            ]
          },
          apiserverudp = {
            name = "apiserverudp"
            # source_addresses = [
            #   "*",
            # ]
            source_ip_groups_keys = [
              "aks_ip_group1"
            ]
            destination_ports = [
              "1194"
            ]
            destination_addresses = [
              "AzureCloud"
            ]
            protocols = [
              "UDP",
            ]
          },
        }
      }          
    }

    # network_rule_collections = {
    #   group1 = {
    #     name     = "network_rule_collection1"
    #     priority = 400
    #     action   = "Deny"
    #     rules = {
    #       rule1 = {
    #         name                  = "network_rule_collection1_rule1"
    #         protocols             = ["TCP", "UDP"]
    #         source_addresses      = ["10.0.0.1"]
    #         destination_addresses = ["192.168.1.1", "192.168.1.2"]
    #         destination_ports     = ["80", "1000-2000"]
    #       }
    #     }
    #   }
    # }

    # nat_rule_collections = {
    #   group1 = {
    #     name     = "nat_rule_collection1"
    #     priority = 300
    #     action   = "Dnat"
    #     rules = {
    #       rule1 = {
    #         name             = "nat_rule_collection1_rule1"
    #         protocols        = ["TCP"]
    #         source_addresses = ["*"]
    #         # destination_address = "192.168.1.1"
    #         destination_address_public_ip_key = "firewall_re1"
    #         destination_ports                 = ["443"]
    #         translated_address                = "100.1.0.4" # TODO: Add private ip of app gw
    #         translated_port                   = "443"
    #       }
    #     }
    #   }
    # }
  }
}