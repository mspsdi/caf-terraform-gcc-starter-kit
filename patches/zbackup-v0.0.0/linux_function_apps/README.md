# How to add a new caf terraform module

This guide provide you a step-by-step example of how to create a new linux_function_app

reference:
https://github.com/claranet/terraform-azurerm-function-app/blob/master/modules/linux-function/r-function.tf

## How to add in a new module libux_function_app in CAF Terraform?

### Step 1: Go to Folder: /tf/caf/landingzones/aztfmod, and modify the below files.


# linux function app
md /tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app
/tf/caf/landingzones/aztfmod/linux_function_app.tf

# caf_solution
/tf/caf/landingzones/caf_solution/local.webapp.tf
/tf/caf/landingzones/caf_solution/variables.webapp.tf

# aztfmod
/tf/caf/landingzones/aztfmod/locals.tf
/tf/caf/landingzones/aztfmod/locals.combined_onjects.tf
/tf/caf/landingzones/aztfmod/local.remote_objects.tf


1. add local objects

file: /tf/caf/landingzones/aztfmod/locals.tf 
e.g.
```bash
    #TODO: add linux and windows funciton apps
    linux_function_apps                            = try(var.webapp.linux_function_apps, {})
```

2. add local combined objects

file: /tf/caf/landingzones/aztfmod/locals.combined_onjects.tf
e.g.
```bash
  #TODO: add linux_function_apps and windows_function_apps
  combined_objects_linux_function_apps                            = merge(tomap({ (local.client_config.landingzone_key) = module.linux_function_apps }), try(var.remote_objects.linux_function_apps, {}))
```

3. add local remote objects

file: /tf/caf/landingzones/aztfmod/local.remote_objects.tf
e.g.
```bash
    #TODO: add funciton apps and linux funciton apps
    function_apps                                  = try(local.combined_objects_function_apps, null)
    linux_function_apps                            = try(local.combined_objects_linux_function_apps, null)
```

4. add new module (to existing tf file or create a new tf file)
ensure to add all variables defined in the variable file /tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app/variables.tf 

file: /tf/caf/landingzones/aztfmod/linux_function_app.tf
e.g.
```bash
# TODO: add linux_function_apps
module "linux_function_apps" {
  source     = "./modules/webapps/linux_function_app"
  depends_on = [module.networking]
  for_each   = local.webapp.linux_function_apps

  # defined all your variables 
...
...
...

}

output "linux_function_apps" {
  value = module.linux_function_apps
}

data "azurerm_storage_account" "linux_function_apps" {
...
...
}
```

### Step 2: create a new folder for the module 
e.g.

md /tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app

### Step 3: add terraform code tf files into the new module folder
e.g.

/tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app/locals.dynamic_app_settings.tf
/tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app/main.tf
/tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app/managed_identities.tf
/tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app/module.tf
/tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app/output.tf
/tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app/variables.tf

### Step 4: modify caf_solution /tf/caf/landingzones/caf_solution
add local variable

not required - xxxx - /tf/caf/landingzones/caf_solution/local.remote.tf

file: /tf/caf/landingzones/caf_solution/local.webapp.tf
e.g.
```bash
      linux_function_apps          = var.linux_function_apps
```

### Step 5: add variable of module 

file: /tf/caf/landingzones/caf_solution/variables.webapp.tf
e.g.
```bash
variable "linux_function_apps" {
  default = {}
}
```

### Step 6: check if roles is required
xxxx /tf/caf/landingzones/aztfmod/roles.tf


xxxx Note: check /tf/caf/landingzones/caf_solution/landingzone.tf to ensure variables are correct (if required)