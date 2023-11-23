if [ "${CODESPACES}" = "true" ]; then
    # Remove the default credential helper
    sudo sed -i -E 's/helper =.*//' /etc/gitconfig

    # Add one that just uses secrets available in the Codespace
    git config --global credential.helper '!f() { sleep 1; echo "username=${GITHUB_USER}"; echo "password=${GH_TOKEN}"; }; f'
fi

sudo chmod 666 /var/run/docker.sock || true
sudo cp -R /tmp/.ssh-localhost/* ~/.ssh
sudo chown -R $(whoami):$(whoami) ~ || true ?>/dev/null
sudo chmod 400 ~/.ssh/*

git config --global core.editor vim
pre-commit install
pre-commit autoupdate

git config --global --add safe.directory /tf/caf
git config --global --add safe.directory /tf/caf/landingzones
git config --global --add safe.directory /tf/caf/landingzones/aztfmod
git config --global --add safe.directory /tf/caf/aztfmod

git config pull.rebase false 

if [ ! -d /tf/caf/landingzones ]; then
  # git clone --branch int-5.6.0 https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/landingzones
  # clone latest caf terraform landingzones - 5.75
  git clone https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/landingzones
  sudo chmod +x /tf/caf/landingzones/templates/**/*.sh
  # git clone aztfmod (if required)
  if [ ! -d /tf/caf/landingzones/aztfmod ]; then
    # clone latest version of aztfmod 5.75
    git clone https://github.com/aztfmod/terraform-azurerm-caf.git /tf/caf/landingzones/aztfmod 
    cd /tf/caf/landingzones/aztfmod 
    # checkout version 5.7.0-preview0
    # git checkout 5.7.0-preview0
    # patch to use local copy of aztfmod, always use latest copy of azurerm - remove version at line 6 at main.tf
    cp /tf/caf/patches/caf_launchpad/landingzone.tf /tf/caf/landingzones/caf_launchpad/landingzone.tf
    cp /tf/caf/patches/caf_solution/landingzone.tf /tf/caf/landingzones/caf_solution/landingzone.tf
    cp /tf/caf/patches/aztfmod/main.tf /tf/caf/landingzones/aztfmod/main.tf 

    # Patches 1: resolve diagnostic days retention issue - remove and comment "days    = log.value[3]" at line 38 and "days    = metric.value[3]" at line 54
    cp /tf/caf/patches/diagnostics/module.tf /tf/caf/landingzones/aztfmod/modules/diagnostics/module.tf

    # Patches 2:  fixed container group subnet_ids 
    cp /tf/caf/patches/container_group/container_group.tf /tf/caf/landingzones/aztfmod/modules/compute/container_group/container_group.tf
    cp /tf/caf/patches/container_group/variables.tf /tf/caf/landingzones/aztfmod/modules/compute/container_group/variables.tf
    cp /tf/caf/patches/container_group/compute_container_groups.tf /tf/caf/landingzones/aztfmod/compute_container_groups.tf


    # Patches 3:  firewall policy tls inspection
    cp /tf/caf/patches/firewall_policies/firewall_policy.tf /tf/caf/landingzones/aztfmod/modules/networking/firewall_policies/firewall_policy.tf

    # Patches 4:  azure bastion host subnet id
    cp /tf/caf/patches/bastion/bastion_service.tf /tf/caf/landingzones/aztfmod/bastion_service.tf
    
    # Patches 5: var local_combined.networking missing from local resources
    cp /tf/caf/patches/container_group/compute_container_groups.tf /tf/caf/landingzones/aztfmod/compute_container_groups.tf

    # Patches ?: apim platform version stv2 - stv2 requirement - public_ip_address_id
    # cp /tf/caf/patches/apim/module.tf /tf/caf/landingzones/aztfmod/modules/apim/api_management/module.tf
    # cp /tf/caf/patches/apim/variables.tf /tf/caf/landingzones/aztfmod/modules/apim/api_management/variables.tf

    # Patches 6: new modules: functionapps: linux function apps, OpenAI: cognitive_service_account, cognitive_deployments, search_services
    # module folder - linux function app

    mkdir  /tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app
    mkdir  /tf/caf/landingzones/aztfmod/modules/cognitive_services/cognitive_deployment
    mkdir  /tf/caf/landingzones/aztfmod/modules/cognitive_services/search_service

    cp  /tf/caf/patches/openai-and-linux-function-apps/linux_function_app/*.* /tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app
    cp /tf/caf/patches/openai-and-linux-function-apps/cognitive_deployment/*.* /tf/caf/landingzones/aztfmod/modules/cognitive_services/cognitive_deployment
    cp /tf/caf/patches/openai-and-linux-function-apps/cognitive_services_account/*.* /tf/caf/landingzones/aztfmod/modules/cognitive_services/cognitive_services_account
    cp /tf/caf/patches/openai-and-linux-function-apps/search_service/*.* /tf/caf/landingzones/aztfmod/modules/cognitive_services/search_service

    # caf_solution
    cp /tf/caf/patches/openai-and-linux-function-apps/caf_solution/local.webapp.tf /tf/caf/landingzones/caf_solution/local.webapp.tf
    cp /tf/caf/patches/openai-and-linux-function-apps/caf_solution/variables.webapp.tf /tf/caf/landingzones/caf_solution/variables.webapp.tf

    cp /tf/caf/patches/openai-and-linux-function-apps/caf_solution/local.cognitive_services.tf /tf/caf/landingzones/caf_solution/local.cognitive_services.tf
    cp /tf/caf/patches/openai-and-linux-function-apps/caf_solution/variables.cognitive_services.tf  /tf/caf/landingzones/caf_solution/variables.cognitive_services.tf

    # aztfmod
    cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/linux_function_apps.tf /tf/caf/landingzones/aztfmod/linux_function_app.tf
    cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/cognitive_deployments.tf /tf/caf/landingzones/aztfmod/cognitive_deployments.tf
    cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/cognitive_search_services.tf /tf/caf/landingzones/aztfmod/cognitive_search_services.tf
    cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/cognitive_service.tf  /tf/caf/landingzones/aztfmod/cognitive_service.tf

    cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/locals.tf /tf/caf/landingzones/aztfmod/locals.tf
    cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/locals.combined_objects.tf /tf/caf/landingzones/aztfmod/locals.combined_objects.tf
    cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/local.remote_objects.tf /tf/caf/landingzones/aztfmod/local.remote_objects.tf

    # Patches 7: fixed apim stsv2.1 add public ip and module for public ip.
    cp /tf/caf/patches/api_management/module.tf /tf/caf/landingzones/aztfmod/modules/apim/api_management/module.tf

    # Patches 8: # fixed bool required for base_tags, diagnostics settings, fixed vnet integration
    cp /tf/caf/patches/logic_app/logic_app.tf /tf/caf/landingzones/aztfmod/logic_app.tf
    cp /tf/caf/patches/logic_app/standard/diagnostic.tf /tf/caf/landingzones/aztfmod/modules/logic_app/standard/diagnostic.tf
    cp /tf/caf/patches/logic_app/standard/variables.tf /tf/caf/landingzones/aztfmod/modules/logic_app/standard/variables.tf
    cp /tf/caf/patches/logic_app/standard/module.tf /tf/caf/landingzones/aztfmod/modules/logic_app/standard/module.tf


    # Patches 9: virtual_subnet_key
    # aztfmod
    cp /tf/caf/patches/virtual_subnets/aztfmod/api_management.tf /tf/caf/landingzones/aztfmod/api_management.tf                   
    cp /tf/caf/patches/virtual_subnets/aztfmod/app_services.tf /tf/caf/landingzones/aztfmod/app_services.tf            
    cp /tf/caf/patches/virtual_subnets/aztfmod/cosmos_db.tf /tf/caf/landingzones/aztfmod/cosmos_db.tf        
    cp /tf/caf/patches/virtual_subnets/aztfmod/redis_caches.tf /tf/caf/landingzones/aztfmod/redis_caches.tf 
    cp /tf/caf/patches/virtual_subnets/aztfmod/application_gateway_platforms.tf  /tf/caf/landingzones/aztfmod/application_gateway_platforms.tf  
    cp /tf/caf/patches/virtual_subnets/aztfmod/compute_aks_clusters.tf  /tf/caf/landingzones/aztfmod/compute_aks_clusters.tf  
    cp /tf/caf/patches/virtual_subnets/aztfmod/compute_container_registry.tf  /tf/caf/landingzones/aztfmod/compute_container_registry.tf          
    cp /tf/caf/patches/virtual_subnets/aztfmod/mssql_servers.tf /tf/caf/landingzones/aztfmod/mssql_servers.tf
    cp //tf/caf/patches/virtual_subnets/aztfmod/bastion_service.tf  /tf/caf/landingzones/aztfmod/bastion_service.tf
                
    # aks       
    cp /tf/caf/patches/virtual_subnets/aks/aks.tf  /tf/caf/landingzones/aztfmod/modules/compute/aks/aks.tf
    cp /tf/caf/patches/virtual_subnets/aks/private_endpoint.tf  /tf/caf/landingzones/aztfmod/modules/compute/aks/private_endpoint.tf 
    cp /tf/caf/patches/virtual_subnets/aks/variables.tf /tf/caf/landingzones/aztfmod/modules/compute/aks/variables.tf

    # api_management
    cp /tf/caf/patches/virtual_subnets/api_management/module.tf /tf/caf/landingzones/aztfmod/modules/apim/api_management/module.tf  
    cp /tf/caf/patches/virtual_subnets/api_management/variables.tf /tf/caf/landingzones/aztfmod/modules/apim/api_management/variables.tf

    # app_services
    cp /tf/caf/patches/virtual_subnets/app_services/private_endpoint.tf /tf/caf/landingzones/aztfmod/modules/webapps/appservice/private_endpoint.tf 
    cp /tf/caf/patches/virtual_subnets/app_services/variables.tf /tf/caf/landingzones/aztfmod/modules/webapps/appservice/variables.tf

    # application_gateway_platforms
    cp /tf/caf/patches/virtual_subnets/application_gateway_platforms/locals.networking.tf /tf/caf/landingzones/aztfmod/modules/networking/application_gateway_platform/locals.networking.tf  
    cp /tf/caf/patches/virtual_subnets/application_gateway_platforms/variable.tf /tf/caf/landingzones/aztfmod/modules/networking/application_gateway_platform/variable.tf

    # container_registry
    cp /tf/caf/patches/virtual_subnets/container_registry/private_endpoint.tf /tf/caf/landingzones/aztfmod/modules/compute/container_registry/private_endpoint.tf 
    cp /tf/caf/patches/virtual_subnets/container_registry/variables.tf /tf/caf/landingzones/aztfmod/modules/compute/container_registry/variables.tf

    # cosmos
    cp /tf/caf/patches/virtual_subnets/cosmos_db/private_endpoints.tf /tf/caf/landingzones/aztfmod/modules/databases/cosmos_dbs/private_endpoints.tf 
    cp /tf/caf/patches/virtual_subnets/cosmos_db/variables.tf  /tf/caf/landingzones/aztfmod/modules/databases/cosmos_dbs/variables.tf

    # mssql_server
    cp /tf/caf/patches/virtual_subnets/mssql_server/private_endpoints.tf /tf/caf/landingzones/aztfmod/modules/databases/mssql_server/private_endpoints.tf 
    cp /tf/caf/patches/virtual_subnets/mssql_server/variables.tf /tf/caf/landingzones/aztfmod/modules/databases/mssql_server/variables.tf

    # redis_caches
    cp /tf/caf/patches/virtual_subnets/redis_caches/private_endpoints.tf  /tf/caf/landingzones/aztfmod/modules/redis_cache/private_endpoints.tf 
    cp /tf/caf/patches/virtual_subnets/redis_caches/variables.tf /tf/caf/landingzones/aztfmod/modules/redis_cache/variables.tf


    # ----------------- OLD PATCHES before Oct 2023 -----------------------------------------------------------------------------  
    # cp /tf/caf/patches/caf_launchpad/main.tf /tf/caf/landingzones/caf_launchpad/main.tf
    # cp /tf/caf/patches/caf_solution/main.tf /tf/caf/landingzones/caf_solution/main.tf
    # patch logic app code no response
    # fixed cp /tf/caf/patches/caf_solution/local.logic_app.tf /tf/caf/landingzones/caf_solution/local.logic_app.tf  
    # optional: fixed and patch azure bastion, container group, sql server
    # fixed - cp /tf/caf/patches/bastion/bastion_service.tf /tf/caf/landingzones/aztfmod/bastion_service.tf
    #>> cp /tf/caf/patches/container_group/container_group.tf /tf/caf/landingzones/aztfmod/modules/compute/container_group/container_group.tf
    # fixed - cp /tf/caf/patches/mssqlserver/private_endpoints.tf /tf/caf/landingzones/aztfmod/modules/databases/mssql_server/private_endpoints.tf
    # Patches 5: application_gateway_application
    # fixed - to test cp /tf/caf/patches/application_gateway_application/scripts/set_resource.sh /tf/caf/landingzones/aztfmod/modules/networking/application_gateway_application/scripts/set_resource.sh
    # manually execute the below steps in agent
    # cp /tf/caf/patches/rover/functions.sh /tf/rover/functions.sh
    # Patches 6: firewall policies - add tls_certificate at line 39
    #>> cp /tf/caf/patches/firewall_policies/firewall_policy.tf /tf/caf/landingzones/aztfmod/modules/networking/firewall_policies/firewall_policy.tf
    # Patches 7: resolve diagnostic days retention issue - remove and comment "days    = log.value[3]" at line 38 and "days    = metric.value[3]" at line 54
    #>> cp /tf/caf/patches/diagnostics/module.tf /tf/caf/landingzones/aztfmod/modules/diagnostics/module.tf
    # Patches 8: The given value is not suitable for module. bool required. base_tags = true # local.tags
    # fixed cp /tf/caf/patches/recovery_vault/private_endpoints.tf /tf/caf/landingzones/aztfmod/modules/recovery_vault/private_endpoints.tf
    cd /tf/caf/
    # note: /tf/caf/landingzones/aztfmod/main.tf show the version of the azurerm

    # Patches 0: fixed dial tcp: lookup xxx.xxx.xxx.xxx: no such host
    # is this required for non MS office network
    sudo chmod -R -f 777 /etc/resolv.conf 
    cp /tf/caf/patches/etc/resolv.conf /etc/resolv.conf

  fi
fi