resource "azurecaf_name" "service" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_cognitive_account"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_cognitive_account" "service" {
  name                = azurecaf_name.service.result
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.settings.kind
  sku_name            = var.settings.sku_name

  qna_runtime_endpoint = var.settings.kind == "QnAMaker" ? var.settings.qna_runtime_endpoint : try(var.settings.qna_runtime_endpoint, null)

  dynamic "network_acls" {
    for_each = can(var.settings.network_acls) ? [var.settings.network_acls] : []
    content {
      default_action = network_acls.value.default_action
      ip_rules       = try(network_acls.value.ip_rules, null)

      # to support migration from 2.99.0 to 3.7.0
      dynamic "virtual_network_rules" {
        for_each = can(network_acls.value.virtual_network_subnet_ids) ? toset(network_acls.value.virtual_network_subnet_ids) : []

        content {
          subnet_id = virtual_network_rules.value
        }
      }

      dynamic "virtual_network_rules" {
        for_each = try(network_acls.value.virtual_network_rules, {})

        content {
          subnet_id                            = virtual_network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = try(virtual_network_rules.value.ignore_missing_vnet_service_endpoint, null)
        }
      }
    }
  }

  custom_subdomain_name = try(var.settings.custom_subdomain_name, null)

  tags = try(var.settings.tags, {})
}


# working - OPENAI azurerm_cognitive_deployment
# resource "azurerm_cognitive_deployment" "deployment" {
#   # for_each = lookup(var.settings, "cognitive_deployments", {})
#   for_each = var.cognitive_deployments

#   name                 = each.value.name # var.settings.deployment_name
#   cognitive_account_id = azurerm_cognitive_account.service.id

#   model {
#     format  = "OpenAI"
#     name    = each.value.model.name # var.settings.model_name # each.value.model.name
#     version = each.value.model.version # var.settings.model_version # each.value.model.version
#   }

#   scale {
#     type = "Standard"
#   }
# }


# # # OPENAI azurerm_cognitive_deployment
# resource "azurerm_cognitive_deployment" "deployment" {

#   cognitive_account_id = azurerm_cognitive_account.service.id

#   for_each = can(var.cognitive_deployments) ? [var.cognitive_deployments] : []  
#   content {

#     name                 = try(cognitive_deployments.value.name, null) # var.settings.deployment_name

#     dynamic "model" {
#       for_each = can(cognitive_deployments.value.model) ? toset(cognitive_deployments.value.model) : []

#       content {
#         # subnet_id = virtual_network_rules.value
#         format  = try(model.value.format, null) # "OpenAI"
#         name    = try(model.value.name, null) # var.settings.model_name # each.value.model.name
#         version = try(model.value.version, null) # var.settings.model_version # each.value.model.version

#       }

#     }

#   }

#   # model {
#   #   format  = "OpenAI"
#   #   name    = try(cognitive_deployments.value.name, null) # var.settings.model_name # each.value.model.name
#   #   version = try(cognitive_deployments.value.name, null) # var.settings.model_version # each.value.model.version
#   # }

#   scale {
#     type = "Standard"
#   }
# }

# # # # OPENAI azurerm_cognitive_deployment
# resource "azurerm_cognitive_deployment" "deployment" {
#   name                 = var.settings.deployment_name
#   cognitive_account_id = azurerm_cognitive_account.service.id

#   model {
#     format  = "OpenAI"
#     name    = var.settings.model_name # each.value.model.name
#     version = var.settings.model_version # each.value.model.version
#   }

#   scale {
#     type = "Standard"
#   }
# }