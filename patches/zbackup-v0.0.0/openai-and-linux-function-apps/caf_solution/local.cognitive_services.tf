locals {
  cognitive_services = merge(
    var.cognitive_services,
    {
      cognitive_services_account = var.cognitive_services_account
      cognitive_deployments = var.cognitive_deployments      
      search_services = var.search_services
    }
  )
}