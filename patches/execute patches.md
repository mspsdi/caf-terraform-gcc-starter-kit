# Patches 01
# Bastion - Add subnet_id
# line 40
# subnet_id            = local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][try(each.value.vnet.vnet_key, each.value.vnet_key)].subnets[try(each.value.vnet.subnet_key, each.value.subnet_key)].id
# 28 Sep 2022 - thiamsoon
# remarks: add in "subnet_id" attribute to accept "subnet_id" variable


cd patches
cp /tf/caf/patches/bastion/bastion_service.tf /tf/caf/landingzones/aztfmod/bastion_service.tf

# Patches 02
# Private Endpoint for Storage Account, function_app
# file changes:
# /tf/caf/landingzones/aztfmod/networking_private_links.tf
# /tf/caf/landingzones/aztfmod/modules/networking/private_links/endpoints/subnet/function_apps.tf
# /tf/caf/landingzones/aztfmod/modules/networking/private_links/endpoints/subnet/storage_accounts.tf

# TODO: Add the changes here
# file: /tf/caf/landingzones/aztfmod/networking_private_links.tf
# line 50 add one line
# function_apps             = local.combined_objects_function_apps

cp /tf/caf/CAF_Patches/function_app/networking_private_links.tf /tf/caf/landingzones/aztfmod/networking_private_links.tf

cp /tf/caf/CAF_Patches/function_app/function_apps.tf /tf/caf/landingzones/aztfmod/modules/networking/private_links/endpoints/subnet/function_apps.tf

cp /tf/caf/CAF_Patches/function_app/storage_accounts.tf /tf/caf/landingzones/aztfmod/modules/networking/private_links/endpoints/subnet/storage_accounts.tf

# Patches 03
# add function_app_linux function
# new file: /tf/caf/landingzones/aztfmod/linux_function_app.tf
# new modules: /tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app
# file changes:
# /tf/caf/landingzones/aztfmod/modules/webapps/function_app/module.tf
# 1. variables to use: /tf/caf/landingzones/aztfmod/function_app.tf
# 2. modules in files in /tf/caf/landingzones/aztfmod/modules/webapps/function_app
do a terraform init
cd landingzones
cd aztfmod
terraform init
# --------------------

# add file
/tf/caf/landingzones/aztfmod/modules/networking/private_links/endpoints/subnet/function_apps.tf

# modify for subnet_ids
/tf/caf/landingzones/aztfmod/modules/networking/private_links/endpoints/subnet/storage_accounts.tf
  subnet_id           = var.subnet_id
  # subnet_id           = can(each.value.subnet_id) ? each.value.subnet_id : var.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
  private_dns         = var.private_dns
  name                = try(each.value.name, each.key)
  resource_group_name = can(each.value.resource_group_key) ? var.resource_groups[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.resource_group_key].name : var.vnet_resource_group_name
  # location            = var.vnet_location # The private endpoint must be deployed in the same region as the virtual network.
  location            = can(each.value.resource_group_key) ? var.resource_groups[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.resource_group_key].location : var.vnet_location # The private endpoint must be deployed in the same region as the virtual network.
  base_tags           = var.base_tags
}

# file: /tf/caf/landingzones/aztfmod/modules/networking/private_links/endpoints/subnets.tf
# line 16
  #vnet_resource_group_name = var.vnet.resource_group_name
  #vnet_location            = var.vnet.location
  vnet_resource_group_name = var.vnet == null ? "" : var.vnet.resource_group_name
  vnet_location            = var.vnet == null ? "" : var.vnet.location
  subnet_id                = var.vnet == null ? each.key : var.vnet.subnets[each.key].id # var.vnet.subnets[each.key].id


# Patches 4: Container Instances
/tf/caf/landingzones/aztfmod/modules/compute/container_group/container_group.tf
line 36
  # thiamsoon: add the subnet_ids
  # subnet_ids - (Optional) The subnet resource IDs for a container group. Changing this forces a new resource to be created.
  # TODO: Fix deprecated network_profile_id with subnet_ids #1641
  # network_profile_id  = try(var.combined_resources.network_profiles[try(var.settings.network_profile.lz_key, var.client_config.landingzone_key)][var.settings.network_profile.key].id, null)
  subnet_ids = try(var.settings.network.subnets, null) == null ? null : [
    for key, value in var.settings.network.subnets : can(value.subnet_id) ? value.subnet_id : var.combined_resources.networking[try(value.lz_key, var.client_config.landingzone_key)][value.vnet_key].subnets[value.subnet_key].id
  ]

cp /tf/caf/patches/container_group/container_group.tf /tf/caf/landingzones/aztfmod/modules/compute/container_group/container_group.tf

# Patches 5: application_gateway_application
cp /tf/caf/patches/application_gateway_application/scripts/set_resource.sh /tf/caf/landingzones/aztfmod/modules/networking/application_gateway_application/scripts/set_resource.sh

# Patches 6: firewall policies - add tls_certificate at line 39
cp /tf/caf/patches/firewall_policies/firewall_policy.tf /tf/caf/landingzones/aztfmod/modules/networking/firewall_policies/firewall_policy.tf

# Patches 7: resolve diagnostic days retention issue - remove and comment "days    = log.value[3]" at line 38 and "days    = metric.value[3]" at line 54
cp /tf/caf/patches/diagnostics/module.tf /tf/caf/landingzones/aztfmod/modules/diagnostics/module.tf

# Patches 8: rover managed identity issue, unable to call access 169.254.169.254
# manually execute the below steps in agent / container instance with managed identity
cp /tf/caf/patches/rover/functions.sh /tf/rover/functions.sh
# ** IMPORTANT - set ARM_USE_MSI = true everytime you bring up the zsh terminal if using agent to execute rover commands
export ARM_USE_MSI=true

