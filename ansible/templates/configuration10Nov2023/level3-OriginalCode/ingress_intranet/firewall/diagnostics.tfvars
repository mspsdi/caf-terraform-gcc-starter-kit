diagnostics_definition = {
  firewall = {
    name = "operational_logs_and_metrics_intranet"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AzureFirewallApplicationRule", true, false, 7],
        ["AzureFirewallNetworkRule", true, false, 7],
        ["AzureFirewallDnsProxy", true, false, 7],
        ["AZFWApplicationRule", true, false, 7],
        ["AZFWApplicationRuleAggregation", true, false, 7],
        ["AZFWDnsQuery", true, false, 7],
        ["AZFWFatFlow", true, true, 7],
        ["AZFWFlowTrace", true, true, 7],
        ["AZFWFqdnResolveFailure", true, false, 7],
        ["AZFWIdpsSignature", true, false, 7],
        ["AZFWNatRule", true, false, 7],
        ["AZFWNatRuleAggregation", true, false, 7],
        ["AZFWNetworkRule", true, false, 7],
        ["AZFWNetworkRuleAggregation", true, false, 7],
        ["AZFWThreatIntel", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }

  }
}

diagnostics_destinations = {
  # Storage keys must reference the azure region name
  log_analytics = {  # <- this is destination type
    central_logs = { # <- this is destination key
      # hange to your subscription id law
      log_analytics_resource_id = "/subscriptions/6f035180-4066-42f0-b0fa-5fbc1ae67500/resourceGroups/gcci-agency-law/providers/Microsoft.OperationalInsights/workspaces/gcci-agency-workspace",
      log_analytics_destination_type = "Dedicated"
    }
  }

}