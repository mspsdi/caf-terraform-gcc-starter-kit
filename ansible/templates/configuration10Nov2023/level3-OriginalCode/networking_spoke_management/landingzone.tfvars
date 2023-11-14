landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level3"
  key                 = "networking_spoke_management" 
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate" # set to launchpad tfstate name
    } 
    networking_spoke_internet = {
      level   = "current"
      tfstate = "networking_spoke_internet.tfstate" # set to referenced landingzone tfstate name      
    }    
  }
}
