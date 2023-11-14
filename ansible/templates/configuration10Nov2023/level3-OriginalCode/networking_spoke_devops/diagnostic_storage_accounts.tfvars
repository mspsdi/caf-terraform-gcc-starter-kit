# diagnostic_storage_accounts = {

#   spoke_devops_central_nsg_flow_logs_sa_re1 = {
#     name                     = "sdddiaglogsre1dz"
#     region                   = "region1"
#     resource_group_key       = "networking_spoke_devops_re1"
#     account_kind             = "StorageV2"
#     account_tier             = "Standard"
#     account_replication_type = "LRS"
#     access_tier              = "Hot"
    
#     tags = { 
#       purpose = "devops diagnostic storage accounts" 
#       project-code = "escep" 
#       env = "uat" 
#       zone = "devops"
#       tier = ""       
#     }       
#   }
# }

# ## destinations definition
# diagnostics_destinations = {
#   spoke_devops_storage = {
#     all_regions = {
#       southeastasia = {
#         storage_account_key = "spoke_devops_central_nsg_flow_logs_sa_re1"
#       }
#     }
#   }
# }