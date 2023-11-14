# diagnostic_storage_accounts = {

#   hub_intranet_central_nsg_flow_logs_sa_re1 = {
#     name                     = "hizdiaglogsre1izhub"
#     region                   = "region1"
#     resource_group_key       = "networking_hub_intranet_re1"
#     account_kind             = "StorageV2"
#     account_tier             = "Standard"
#     account_replication_type = "LRS"
#     access_tier              = "Hot"
    
#     tags = { 
#       purpose = "hub intranet diagnostic_storage_accounts" 
#       project-code = "escep" 
#       env = "uat" 
#       zone = "intranet"
#       tier = "ingress"       
#     }       
#   }
# }

# ## destinations definition
# diagnostics_destinations = {
#   hub_intranet_storage = {
#     all_regions = {
#       southeastasia = {
#         storage_account_key = "hub_intranet_central_nsg_flow_logs_sa_re1"
#       }
#     }
#   }
# }