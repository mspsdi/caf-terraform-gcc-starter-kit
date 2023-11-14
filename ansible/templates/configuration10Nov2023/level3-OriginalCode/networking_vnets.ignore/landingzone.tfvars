landingzone = {
  backend_type        = "azurerm"
  level               = "level3"
  key                 = "vnets"
  global_settings_key = "launchpad"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}






