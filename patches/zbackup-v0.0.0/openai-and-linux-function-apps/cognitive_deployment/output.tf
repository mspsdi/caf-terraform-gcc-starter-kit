output "id" {
  description = "The ID of the Cognitive Deployment."
  value       = azurerm_cognitive_deployment.deployment.id
}

# output "endpoint" {
#   description = "The endpoint used to connect to the Cognitive Deployment."
#   value       = azurerm_cognitive_deployment.service.endpoint
# }