# upload tfstate file
## execute the below commands to create the subnets.

az storage blob upload --account-name <storage-account> --container-name <container> --name myFile.txt --file myFile.txt --auth-mode login



rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/caf_terraform_starter_osscuat_sandpit/landingzone/configuration/level3/networking_vnets \
-env sandpit \
-tfstate networking_vnets.tfstate \
-a apply


gcci variable 
rg: osscuatabc-rg-gcci-platform > gcci-platform
rg: osscuatabc-rg-gcci-agency-law > gcci-agency-law
law: osscuatabc-log-gcci-agency-workspace >  gcci-agency-workspace

TODO: replace the above variables


osscuatabc-vnet-hub-internet-egress-re1
osscuatabc-vnet-hub-internet-ingress-re1
osscuatabc-vnet-hub-intranet-egress-re1
osscuatabc-vnet-hub-intranet-ingress-re1
osscuatabc-vnet-spoke-devops-re1
osscuatabc-vnet-spoke-internet-re1
osscuatabc-vnet-spoke-management-re1



gcci-vnet-egress-internet
gcci-vnet-ingress-internet
gcci-vnet-egress-intranet
gcci-vnet-ingress-intranet
gcci-vnet-devops
gcci-vnet-internet
gcci-vnet-management



Additional meta data:

workspace_id = ca2e37fc-07f3-4cf8-800f-35e900cfdec6



# Importing Terraform State in Azure
link: https://techcommunity.microsoft.com/t5/microsoft-learn/importing-terraform-state-in-azure/m-p/3421289


write the tf file for the imported resources.

After creating the configuration tf file, we can import these resources into it by using the "terraform import" command : 
terraform import terraform_id azure_resource_id

1- Resource Group : 
e.g. terraform import "azurerm_resource_group.rg_name_auto" "/subscriptions/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/resourceGroups/d-210-rg-ado-si-p-to-6"
<!--
resource "azurerm_resource_group" "rg" { # << terraform_id
  name     = azurecaf_name.rg.result
  location = var.global_settings.regions[lookup(var.settings, "region", var.global_settings.default_region)]
  tags     = merge(local.tags, try(var.settings.tags, null))
}
-->

terraform import "azurerm_resource_group.rg" "/subscriptions/e22a351f-db36-4a02-9793-0f2189d5f3ab/resourceGroups/gcci-platform"


2-  The Vnet :
e.g. terraform import "azurerm_virtual_network.vnet_auto" "/subscriptions/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxid/resourceGroups/d-210-rg-ado-si-p-to-6/providers/Microsoft.Network/virtualNetworks/d-210-vnet-ado-si-p-to-1"
<!--
resource "azurerm_virtual_network" "vnet" { # <<terraform_id
-->


terraform import "azurerm_virtual_network.vnet" "/subscriptions/e22a351f-db36-4a02-9793-0f2189d5f3ab/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-ingress-internet"




So, before use this commands, please : 

1- access the code folder : cd folder_code

2- connect to the subscription (where you have deployed the manual resources) : 

az login 

Select-AzSubscription -SubscriptionId "copy-past the id of the subsc" 


3-  Terraform init : 

e.g. terraform init -backend-config storage_account_name=osscuatabcstlevel3 -backend-config container_name=tfstate -backend-config resource_group_name=osscuatabc-rg-launchpad-level3 -backend-config key=networking_vnets.tfstate

 terraform init -backend-config storage_account_name=osscuatabcstlevel3 -backend-config container_name=tfstate -backend-config resource_group_name=osscuatabc-rg-launchpad-level3 -backend-config key=networking_vnets.tfstate


4. Okey, now we can lunch the commands for import config : 

RG:
terraform import "azurerm_resource_group.rg" "/subscriptions/e22a351f-db36-4a02-9793-0f2189d5f3ab/resourceGroups/gcci-platform"


VNET:

terraform import "azurerm_virtual_network.vnet" "/subscriptions/e22a351f-db36-4a02-9793-0f2189d5f3ab/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-ingress-internet"



---------------------

terraform import "azurerm_virtual_network.vnet_auto" "/subscriptions/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxid/resourceGroups/d-210-rg-ado-si-p-to-6/providers/Microsoft.Network/virtualNetworks/d-210-vnet-ado-si-p-to-1"

terraform init -backend-config storage_account_name=xxxxxxxx -backend-config container_name=tfstate -backend-config resource_group_name=xxxxxxxx -backend-config key=xxxxxxx.tfstate
