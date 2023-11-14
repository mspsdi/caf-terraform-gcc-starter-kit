module "search_services" {
  source   = "./modules/cognitive_services/search_service"
  for_each = local.cognitive_services.search_services

  # begin default
  client_config       = local.client_config
  global_settings     = local.global_settings
  resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location : local.global_settings.regions[each.value.region]
  
  private_endpoints   = try(each.value.private_endpoints, {})

  settings            = each.value
  # end default

  # additonal variables
  private_dns         = local.combined_objects_private_dns
  resource_groups     = local.combined_objects_resource_groups
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]

  base_tags           = local.global_settings.inherit_tags
  tags                = try(each.value.tags, {})  

  vnets               = local.combined_objects_networking
  virtual_subnets     = local.combined_objects_virtual_subnets
  diagnostics         = local.combined_diagnostics
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
}

output "search_service" {
  value = module.search_services
}

