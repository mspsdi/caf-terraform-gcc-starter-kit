output "id" {
  description = "The ID of the Search Service."
  value       = azurerm_search_service.search.id
}

output "name" {
  description = "The endpoint used to connect to the Search Service Name."
  value       = azurerm_search_service.search.name
}

# output "endpoint" {
#   description = "The endpoint used to connect to the search Service Account."
#   value       = azurerm_search_service.search.endpoint
# }