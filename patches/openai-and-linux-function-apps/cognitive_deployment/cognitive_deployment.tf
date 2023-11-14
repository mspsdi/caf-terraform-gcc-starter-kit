resource "azurecaf_name" "service" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_cognitive_account"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_cognitive_deployment" "deployment" {

  name                = azurecaf_name.service.result # lookup(var.settings, "name", null) # var.settings.name # merge(azurecaf_name.service.result,"-deployment") # azurecaf_name.service.result # merge(azurecaf_name.service.result,"-deployment", string)

  cognitive_account_id = var.resource_id # azurerm_cognitive_account.service.id

  model {
    format  = lookup(var.settings.model, "format", null) # var.settings.model.format # "OpenAI"
    name    = lookup(var.settings.model, "name", null) # var.settings.model.name
    version = lookup(var.settings.model, "version", null) # var.settings.model.version
  }

  scale {
    type = "Standard"
  }
}