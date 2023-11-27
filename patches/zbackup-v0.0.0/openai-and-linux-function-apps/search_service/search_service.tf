resource "azurecaf_name" "search" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_cognitive_account"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


# resource "azurecaf_name" "pep" {
#   name          = var.settings.name
#   prefixes      = var.global_settings.prefixes  
#   resource_type = "azurerm_private_endpoint"
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

# The following arguments are supported:

# location - (Required) The Azure Region where the Search Service should exist. Changing this forces a new Search Service to be created.

# name - (Required) The Name which should be used for this Search Service. Changing this forces a new Search Service to be created.

# resource_group_name - (Required) The name of the Resource Group where the Search Service should exist. Changing this forces a new Search Service to be created.

# sku - (Required) The SKU which should be used for this Search Service. Possible values include basic, free, standard, standard2, standard3, storage_optimized_l1 and storage_optimized_l2. Changing this forces a new Search Service to be created.

# Note
# The basic and free SKUs provision the Search Service in a Shared Cluster - the standard SKUs use a Dedicated Cluster.

# NOTE:
# The SKUs standard2, standard3, storage_optimized_l1 and storage_optimized_l2 are only available by submitting a quota increase request to Microsoft. Please see the product documentation on how to submit a quota increase request.

# allowed_ips - (Optional) Specifies a list of inbound IPv4 or CIDRs that are allowed to access the Search Service. If the incoming IP request is from an IP address which is not included in the allowed_ips it will be blocked by the Search Services firewall.
# NOTE:
# The allowed_ips are only applied if the public_network_access_enabled field has been set to true, else all traffic over the public interface will be rejected, even if the allowed_ips field has been defined. When the public_network_access_enabled field has been set to false the private endpoint connections are the only allowed access point to the Search Service.

# authentication_failure_mode - (Optional) Specifies the response that the Search Service should return for requests that fail authentication. Possible values include http401WithBearerChallenge or http403.
# NOTE:
# authentication_failure_mode can only be configured when using local_authentication_enabled is set to true - which when set together specifies that both API Keys and AzureAD Authentication should be supported.

# customer_managed_key_enforcement_enabled - (Optional) Specifies whether the Search Service should enforce that non-customer resources are encrypted. Defaults to false.

# hosting_mode - (Optional) Specifies the Hosting Mode, which allows for High Density partitions (that allow for up to 1000 indexes) should be supported. Possible values are highDensity or default. Defaults to default. Changing this forces a new Search Service to be created.

# NOTE:
# hosting_mode can only be configured when sku is set to standard3.

# identity - (Optional) An identity block as defined below.

# local_authentication_enabled - (Optional) Specifies whether the Search Service allows authenticating using API Keys? Defaults to false.

# partition_count - (Optional) Specifies the number of partitions which should be created. This field cannot be set when using a free or basic sku (see the Microsoft documentation). Possible values include 1, 2, 3, 4, 6, or 12. Defaults to 1.

# NOTE:
# when hosting_mode is set to highDensity the maximum number of partitions allowed is 3.

# public_network_access_enabled - (Optional) Specifies whether Public Network Access is allowed for this resource. Defaults to true.

# replica_count - (Optional) Specifies the number of Replica's which should be created for this Search Service. This field cannot be set when using a free sku (see the Microsoft documentation).

# tags - (Optional) Specifies a mapping of tags which should be assigned to this Search Service.

# An identity block supports the following:

# type - (Required) Specifies the type of Managed Service Identity that should be configured on this Search Service. The only possible value is SystemAssigned.


resource "azurerm_search_service" "search" {

  name                = azurecaf_name.search.result # random_string.azurerm_search_service_name.result
  resource_group_name = var.resource_group_name # azurerm_resource_group.rg.name
  location            = var.location # azurerm_resource_group.rg.location
  sku                 = var.settings.sku # "standard" # var.settings.sku

  allowed_ips         = lookup(var.settings, "allowed_ips", null)
  authentication_failure_mode = lookup(var.settings, "authentication_failure_mode", null)

  customer_managed_key_enforcement_enabled          = lookup(var.settings, "customer_managed_key_enforcement_enabled", null)
  hosting_mode        = lookup(var.settings, "hosting_mode", null)
  
  dynamic "identity" {
    for_each = lookup(var.settings, "identity", {}) != {} ? [1] : []
    content {
      type         = lookup(identity.value, "type", null)
    }
  }

  local_authentication_enabled   = lookup(var.settings, "local_authentication_enabled", null)
  partition_count     = lookup(var.settings, "partition_count", null)
  public_network_access_enabled   = lookup(var.settings, "public_network_access_enabled", null)
  replica_count       = lookup(var.settings, "replica_count", null)
  tags                = merge(local.tags, try(var.settings.tags, {}))


  # replica_count       = var.settings.replica_count
  # partition_count     = var.settings.partition_count

  # name                = azurecaf_name.search.result # random_string.azurerm_search_service_name.result
  # resource_group_name = var.resource_group_name # azurerm_resource_group.rg.name
  # location            = var.location # azurerm_resource_group.rg.location
  # sku                 = "standard" # var.settings.sku
  # replica_count       = 1 # var.settings.replica_count
  # partition_count     = 1 # var.settings.partition_count

  # local_authentication_enabled = false


  # name                = "example-resource"
  # resource_group_name = azurerm_resource_group.example.name
  # location            = azurerm_resource_group.example.location
  # sku                 = "standard"

  # local_authentication_enabled = false

  # target sub resource = "searchService"
}

# resource "azurerm_private_endpoint" "pep" {

#   name                = azurecaf_name.pep.result
#   location            = var.location # "southeastasia" # var.location
#   resource_group_name = var.resource_group_name  # "openai-rg-openai-re1" # var.resource_group_name  
#   subnet_id           = var.settings.subnet_id # "/subscriptions/0b5b13b8-0ad7-4552-936f-8fae87e0633f/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet/subnets/openai-snet-app-internet" # var.settings.subnet_id
#   tags = try(var.settings.tags, {})  

#   private_service_connection {
#     name                           = "${azurecaf_name.pep.result}-psc" 
#     private_connection_resource_id = azurerm_search_service.search.id # var.resource_id
#     is_manual_connection           = false 
#     subresource_names              = ["searchService"] 
#     # request_message                = try(each.value.private_service_connection.request_message, null)
#   }

#   private_dns_zone_group {
#     name = "${azurecaf_name.pep.result}-zone-group-name" # lookup(private_dns_zone_group.value, "zone_group_name", "default")
#     private_dns_zone_ids = flatten([
#         for key in try(var.settings.private_dns_zone_keys, []) : [
#           try(var.private_dns[try(var.settings.private_dns_zone_lz_key, var.client_config.landingzone_key)][key].id, [])
#         ]
#         ]
#       ) 
#   }

# }

# resource "azurerm_cognitive_account" "openai" {

#   name                = azurecaf_name.openai.result
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   kind                = "OpenAI" 
#   custom_subdomain_name = try(var.settings.custom_subdomain_name, null)
#   sku_name            = var.settings.sku_name
#   public_network_access_enabled = try(var.settings.public_network_access_enabled, null)  # set to false
#   tags = try(var.settings.tags, {})

#   identity {
#     type = "SystemAssigned"
#   }

#   lifecycle {
#     ignore_changes = [
#       tags
#     ]
#   }

# }


# resource "azurerm_cognitive_deployment" "deployment" {

#   name = concat(azurecaf_name.openai.result, var.settings.deployment_name) 
#   cognitive_account_id = azurerm_cognitive_account.openai.id
#   model {
#     format  = "OpenAI"
#     name    = var.settings.model_name # "gpt-35-turbo"
#     version = var.settings.model_version # "0613"
#   }

#   scale {
#     type = "Standard"
#   }

# }

## https://msandbu.org/deploy-azure-openai-using-terraform-with-private-endpoint/
# resource "azurerm_private_endpoint" "example-pe01" {
#   name                = "pe-openai-we"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   subnet_id           = azurerm_subnet.example-subnet.id


#   private_service_connection {
#     name                           = "pe-openai-we"
#     private_connection_resource_id = azurerm_cognitive_account.example.id
#     subresource_names              = ["account"]
#     is_manual_connection           = false
#   }

#   private_dns_zone_group {
#     name                 = "default"
#     private_dns_zone_ids = [azurerm_private_dns_zone.example.id]
#   }
# }


# # TODO: 23 Oct 2023 - below private endpoint not taking effect. To verify again.
# resource "azurerm_private_endpoint" "pep" {

#   name                = azurecaf_name.pep.result
#   location            = "southeastasia" # var.location
#   resource_group_name = "openai-rg-openai-re1" # var.resource_group_name  
#   subnet_id           = "/subscriptions/0b5b13b8-0ad7-4552-936f-8fae87e0633f/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet/subnets/openai-snet-app-internet" # var.settings.subnet_id
#   tags = try(var.settings.tags, {})  

#   private_service_connection {
#     name                           = "${azurecaf_name.pep.result}-psc" 
#     private_connection_resource_id = azurerm_cognitive_account.openai.id # var.resource_id
#     is_manual_connection           = false 
#     subresource_names              = ["account"] 
#     # request_message                = try(each.value.private_service_connection.request_message, null)
#   }

#   private_dns_zone_group {
#     name = "${azurecaf_name.pep.result}-zone-group-name" # lookup(private_dns_zone_group.value, "zone_group_name", "default")
#     private_dns_zone_ids = flatten([
#         for key in try(var.settings.private_dns_zone_keys, []) : [
#           try(var.private_dns[try(var.settings.private_dns_zone_lz_key, var.client_config.landingzone_key)][key].id, [])
#         ]
#         ]
#       ) 
#   }

# }

