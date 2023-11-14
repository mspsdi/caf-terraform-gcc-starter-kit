#
# Note: diagnostic_log_analytics is pre-created by GCC during onboarding
# use log_analytics_resource_id instead of log_analytics_key
#

diagnostics_destinations = {
  # Storage keys must reference the azure region name
  log_analytics = {   # <- this is destination type
    central_logs = {  # <- this is destination key
      log_analytics_resource_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-agency-law/providers/Microsoft.OperationalInsights/workspaces/gcci-agency-workspace",
      log_analytics_destination_type = "Dedicated"
    }
  }

}
