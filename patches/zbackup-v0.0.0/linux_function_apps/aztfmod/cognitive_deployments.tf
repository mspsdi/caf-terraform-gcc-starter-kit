module "cognitive_deployments" {
  source   = "./modules/cognitive_services/cognitive_deployment"
  for_each = local.cognitive_services.cognitive_deployments

  client_config       = local.client_config
  global_settings     = local.global_settings
  # resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  # location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location : local.global_settings.regions[each.value.region]
  settings            = try(each.value, {})

  base_tags           = local.global_settings.inherit_tags
  # tags                = try(each.value.tags, {})  
  resource_id         = lookup(each.value, "resource_id", null)
}

output "cognitive_deployments" {
  value = module.cognitive_deployments
}
