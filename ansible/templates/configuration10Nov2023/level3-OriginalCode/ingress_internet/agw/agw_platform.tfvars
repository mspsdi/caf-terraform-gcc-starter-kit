#
# Reference Example: /tf/caf/landingzones/aztfmod/examples/app_gateway/301-agw-v1
#
# 1. There is public IP which is not use.
# You can deploy Application Gateway with Public IP and Private IP. All you need to do is to create the listener with the private Frontend IP and leave the Public IP as such without a listener.
# Since Public IP is not attached with any of the listener, no one will be able to access your site from Internet via Public IP of your Application Gateway.

# 1. agw must deploy inside s01-rg-aks-nodes-re1 or 
# 2. grant permission ingressapplicationgateway-s01-aks-cluster-re1 and s01-msi-aks-usermsi to s01-rg-aks-re1 resource group
#
application_gateway_platforms = {
  agw1 = {
    resource_group_key = "agw_re1"
    name               = "ingress-reverse-proxy"
    vnet_key = "vnet_hub_internet_ingress_re1"
    subnet_key = "ApplicationGatewaySubnet"
    lz_key = "networking_hub_internet"    
    #         subnet_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-ingress-internet/subnets/escep-snet-ingress-agw"

    sku_name  = "WAF_v2"
    sku_tier  = "WAF_v2"    
    capacity = {
      autoscale = {
        minimum_scale_unit = 0
        maximum_scale_unit = 5
      }
    }

    # add the waf policy
    waf_policy = {
      key = "agw_wp_re1" 
    }

    zones        = ["1"]  # ["1", "2", "3"]
    enable_http2 = true

    identity = {
      managed_identity_keys = [
        "agw1_keyvault_demo_certs"
      ]
    }

    front_end_ip_configurations = {
      public = {
        name          = "public"
        public_ip_key = "agw_pip_re1"
      }
      private = {
        name                          = "private"
        vnet_key = "vnet_hub_internet_ingress_re1"
        subnet_key = "ApplicationGatewaySubnet"
        lz_key = "networking_hub_internet"    
        #                 subnet_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-ingress-internet/subnets/escep-snet-ingress-agw"
        subnet_cidr = "100.1.0.64/26" # TODO: set the web subnet cidr range - hardcoded here         
        subnet_cidr_index             = 0 # It is possible to have more than one cidr block per subnet
        private_ip_offset             = 10 # do not use 4, the private ip is in use, use > 4 # e.g. cidrhost(10.10.0.0/25,4) = 10.10.0.4 => AGW private IP address
        private_ip_address_allocation = "Static"
      }
    }

    front_end_ports = {
      80 = {
        name     = "http"
        port     = 80
        protocol = "Http"
      }
      8080 = {
        name     = "http8080"
        port     = 8080
        protocol = "Https"
      }      
      443 = {
        name     = "https"
        port     = 443
        protocol = "Https"
      }
    }

    #default: wont be able to change after creation as this is required for agw tf resource
    default = {
      frontend_port_key             = "80"
      frontend_ip_configuration_key = "public"
      backend_address_pool_name     = "default-beap"
      http_setting_name             = "default-be-htst"
      listener_name                 = "default-httplstn"
      request_routing_rule_name     = "default-rqrt"
      cookie_based_affinity         = "Disabled"
      request_timeout               = "60"
      rule_type                     = "Basic"
      priority                      = 50
    }

    listener_ssl_policy = {
      default = {
        policy_type          = "Predefined"
        policy_name          = "AppGwSslPolicy20170401S"
        min_protocol_version = "TLSv1_2"
      }
    }

    # TODO: debug the diagnostic_profiles - this is working 10 Aug 2023
    # you can setup up to 5 key
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "application_gateway"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
        lz_key = "shared_services" # TODO: is this required?
      }
    }

    tags = { 
      purpose = "internet web reverse proxy application gateway" 
      project-code = "escep" 
      env = "uat" 
      zone = "internet"
      tier = "ingress"           
    } 
        
  }
}
