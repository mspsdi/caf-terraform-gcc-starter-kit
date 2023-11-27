module "cognitive_services_account" {
  source   = "./modules/cognitive_services/cognitive_services_account"
  for_each = local.cognitive_services.cognitive_services_account

  client_config       = local.client_config
  global_settings     = local.global_settings
  resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location : local.global_settings.regions[each.value.region]
  settings            = each.value

  base_tags           = local.global_settings.inherit_tags
  tags                = try(each.value.tags, {})    
  
  cognitive_deployments   = try(each.value.cognitive_deployments, {})
  private_endpoints   = try(each.value.private_endpoints, {})
  private_dns       = local.combined_objects_private_dns

  vnets               = local.combined_objects_networking
  virtual_subnets     = local.combined_objects_virtual_subnets
  diagnostics         = local.combined_diagnostics
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  # global_settings   = local.global_settings
  # client_config     = local.client_config
  # private_endpoints = try(each.value.private_endpoints, {})
  # resource_groups   = try(each.value.private_endpoints, {}) == {} ? null : local.resource_groups
  # vnets             = local.combined_objects_networking
  # settings          = each.value
  # private_dns       = local.combined_objects_private_dns

  # base_tags           = local.global_settings.inherit_tags
  # resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  # resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  # location            = try(local.global_settings.regions[each.value.region], null)


}

output "cognitive_services_account" {
  value = module.cognitive_services_account
}
