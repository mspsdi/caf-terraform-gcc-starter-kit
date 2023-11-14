
resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  vnet_rg_re1 = {
    # name   = "dev-env-re1"
    name   = "platform-vnets"
  }
  law_rg_re1 = {
    # name   = "dev-env-law-re1"
    name   = "platform-law"
  }  
}





