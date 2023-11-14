# diagnostic_storage_accounts = {

#   hub_internet_central_nsg_flow_logs_sa_re1 = {
#     name                     = "hezdiaglogsre1ezhub"
#     region                   = "region1"
#     resource_group_key       = "networking_hub_internet_re1"
#     account_kind             = "StorageV2"
#     account_tier             = "Standard"
#     account_replication_type = "LRS"
#     access_tier              = "Hot"
    
#     tags = { 
#       purpose = "hub internet diagnostic_storage_accounts" 
#       project-code = "escep" 
#       env = "uat" 
#       zone = "internet"
#       tier = ""         
#     }       
#   }
# }

# ## destinations definition
# diagnostics_destinations = {
#   hub_internet_storage = {
#     all_regions = {
#       southeastasia = {
#         storage_account_key = "hub_internet_central_nsg_flow_logs_sa_re1"
#       }
#     }
#   }
# }