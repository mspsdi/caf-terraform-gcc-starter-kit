# diagnostic_storage_accounts = {

#   spoke_internet_central_nsg_flow_logs_sa_re1 = {
#     name                     = "sidiaglogsre1ez" # TODO: check if this need to be change
#     region                   = "region1"
#     resource_group_key       = "networking_spoke_internet_re1"
#     account_kind             = "StorageV2"
#     account_tier             = "Standard"
#     account_replication_type = "LRS"
#     access_tier              = "Hot"

#     # network = {
#     #   bypass = ["None"]
#     #   subnets = {
#     #     subnet1 = {
#     #       # devops subnet id
#     #       remote_subnet_id = ""
#     #     }
#     #   }
#     # }
    
#     tags = { 
#       purpose = "internet diagnostic_storage_accounts" 
#       project-code = "ignite" 
#       env = "uat" 
#       zone = "internet"        
#     }       
#   }
# }

# ## destinations definition
# diagnostics_destinations = {
#   spoke_internet_storage = {
#     all_regions = {
#       southeastasia = {
#         storage_account_key = "spoke_internet_central_nsg_flow_logs_sa_re1"
#       }
#       # australiacentral = {
#       #   storage_account_key = "diaglogs_region2"
#       # }
#     }
#   }
# }