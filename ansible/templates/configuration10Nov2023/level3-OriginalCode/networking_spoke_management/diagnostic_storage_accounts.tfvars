# diagnostic_storage_accounts = {

#   spoke_management_central_nsg_flow_logs_sa_re1 = {
#     name                     = "smdiaglogsre1mz"
#     region                   = "region1"
#     resource_group_key       = "networking_spoke_management_re1"
#     account_kind             = "StorageV2"
#     account_tier             = "Standard"
#     account_replication_type = "LRS"
#     access_tier              = "Hot"
    
#     tags = { 
#       purpose = "spoke management diagnostic storage accounts" 
#       project-code = "escep" 
#       env = "uat" 
#       zone = "management"
#       tier = ""         
#     }       
#   }
# }

# ## destinations definition
# diagnostics_destinations = {
#   spoke_management_storage = {
#     all_regions = {
#       southeastasia = {
#         storage_account_key = "spoke_management_central_nsg_flow_logs_sa_re1"
#       }
#     }
#   }
# }