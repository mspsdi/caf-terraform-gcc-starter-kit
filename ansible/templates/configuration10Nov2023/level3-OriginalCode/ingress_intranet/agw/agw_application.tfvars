
application_gateway_applications_v1 = {
  app1 = {
    name                    = "app1"
    application_gateway_key = "agw1"

    # set to aks lb
    backend_pools = {
      app1_bep = {
        name  = "app1-bep"
        fqdns = ["aks-openai.rsaf.gov.sg"] #  ["aks.intranet.caflabs.com"] # TODO: set to the aks fqdn - set private dns "caflabs.com" A record "aks" ipaddress "100.2.0.95"
        # ip_addresses = ["100.2.0.95"] # aks internal lb ingress controller ip address
      }          
    }

    # backend http setting for aks
    http_settings = {
      app1_http = {
        name                        = "app1_http_setting"
        front_end_port_key          = "80"
        host_name_from_backend_pool = true
        timeout                     = 45
      } 
      app1_https = {
        name                        = "app1_https_setting"
        front_end_port_key          = "443"
        host_name_from_backend_pool = true
        timeout                     = 45
      }              
    }

    # frontend_ports to be used only if application configuraiton uses non standards https/https ports i.e anything other than 80/443
    frontend_ports = {
      "8443" = {
        name = "8443"
        port = 8443
      }
      "8081" = {
        name = "8081"
        port = 8081
      }   
    }

    http_listeners = {
      public = { # working
        name                           = "app1_http_8081_public_listener"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "8081"
        host_name                      = "openai.rsaf.gov.sg" # "demoapp1.intranet.caflabs.com" # TODO: set to your application fqdn
      }
      private = { # working
        name                           = "app1_http_80_private_listener"
        front_end_ip_configuration_key = "private" # set to private frontend ip # "public"
        front_end_port_key             = "80"
        host_name                      = "openai.rsaf.gov.sg" # "demoapp1.intranet.caflabs.com" # TODO: set to your application fqdn
      }        
      private = { # working
        name                           = "app1_http_8080_private_listener"
        front_end_ip_configuration_key = "private" # set to private frontend ip # "public"
        front_end_port_key             = "8080"
        host_name                      = "openai.rsaf.gov.sg" # "demoapp1.intranet.caflabs.com" # TODO: set to your application fqdn
      }        
      private_ssl = {
        name                           = "app1_https_listener"
        front_end_ip_configuration_key = "private" # set to private frontend ip # "public"
        front_end_port_key             = "443"
        host_name                      = "openai.rsaf.gov.sg" # "demoapp1.intranet.caflabs.com" # TODO: set to your application fqdn
        ssl_cert_key                   = "app1_ssl_cert" # ssl cert for appgateway
      }    
    }

    request_routing_rules = {
      default = {
        name              = "default_app1_app1"
        rule_type         = "PathBasedRouting"
        http_listener_key = "public" # 80
        backend_pool_key  = "app1_bep" # aks.intranet.caflabs.com
        http_settings_key = "app1_http" # 80
        url_path_map_key  = "app1_url_path_map"
        priority          = 100
      }
      default_private = {
        name              = "default-app1-private"
        rule_type         = "PathBasedRouting"
        http_listener_key = "private" # 8080
        backend_pool_key  = "app1_bep" # aks.intranet.caflabs.com
        http_settings_key = "app1_http" # 80
        url_path_map_key  = "app1_url_path_map"
        priority          = 200
      } 
      default_private_ssl = {
        name              = "default-app1-private-ssl"
        rule_type         = "PathBasedRouting"
        http_listener_key = "private_ssl" # 443
        backend_pool_key  = "app1_bep" # aks.intranet.caflabs.com
        http_settings_key = "app1_http" # 80 - TODO: set to "app1_https" if using 443 at aks
        url_path_map_key  = "app1_url_path_map"
        priority          = 300
      }             
    }

    ssl_certs = {
      app1_ssl_cert = {
        name = "app1"
        keyvault = {
          certificate_key ="openai.rsaf.gov.sg" #  "demoapp1.intranet.caflabs.com" 
          # certificate_request_key = "wildcard_ingress" #for cert request

          # lz_key                  = "" #remote keyvault
          # manual cert
          # key                     = "" #keyvault key
          # certificate_name        = "" #manual cert name
        }
      }
      app2_ssl_cert = {
        name = "aks1"
        keyvault = {
          certificate_key = "aks-openai.rsaf.gov.sg" #  "aks.intranet.caflabs.com"
          # certificate_request_key = "wildcard_ingress" #for cert request

        }
      }      
    }

    url_path_maps = { # similar to url_path_rules
      app1_url_path_map = {
        name              = "url_path_map1"
        paths             = "/api2/*" 
        rule_name         = "path-rule1"
        backend_pool_key  = "app1_bep"
        http_settings_key = "app1_http"
      }
    }

    url_path_rules = {
      rule1 = {
        name             = "rule1-app1"
        url_path_map_key = "app1_url_path_map"
        paths            = "/api/*"
        backend_pool_key  = "app1_bep"
        http_settings_key = "app1_http"        
      }
      # rule2 = {
      #   name             = "rule2-app1"
      #   url_path_map_key = "app1_url_path_map"
      #   paths            = "/api1/*" # TODO: test if this is set correctly
      #   backend_pool_key  = "app1_bep"
      #   http_settings_key = "app1_http"        
      # }

    }

    probes = {
      test = {
        name                         = "app1-http"
        protocol                     = "Http" # Http or Https
        host                         = "aks-openai.rsaf.gov.sg" # "aks.intranet.caflabs.com"
        host_name_from_http_settings = false
        # port               = "" # Leave not set if pick port from backend http settings
        path               = "/" # "/api/health"
        interval           = "60"
        timeout            = "60"
        threshold          = "3"
        min_servers        = "0"
        match_status_codes = "200-499"
      }
    }
  }
}