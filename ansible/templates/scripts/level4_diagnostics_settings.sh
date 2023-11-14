

# sql server
  # mssql_db = {
  #   name = "mssql_db_logs_and_metrics"

  #   categories = {
  #     log = [
  #       #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
  #       ["AutomaticTuning", true, false, 7],
  #       ["Blocks", true, false, 7],
  #       ["DatabaseWaitStatistics", true, false, 7],
  #       ["Deadlocks", true, false, 7],
  #       # ["DevOpsOperationsAudit", true, false, 7],
  #       ["QueryStoreRuntimeStatistics", true, false, 7],
  #       ["QueryStoreWaitStatistics", true, false, 7],
  #       ["SQLInsights", true, false, 7],
  #       # ["SQLSecurityAuditEvents", true, false, 7],
  #       ["Timeouts", true, false, 7],
  #       ["Errors", true, false, 7],

  #     ]
  #     metric = [
  #       #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
  #       ["Basic", true, false, 7],
  #       ["InstanceAndAppAdvanced", true, false, 7],
  #       ["WorkloadManagement", true, false, 7],
  #     ]
  #   }
  # }

az monitor diagnostic-settings create \
--resource "/subscriptions/{{subscription_id}}/resourceGroups/esdso-rg-mssql-ddj/providers/Microsoft.Sql/servers/esdso-sql-mssql-server-dug/databases/esdso-sqldb-sqldb1-qkx" \
-n "mssql_db_logs_and_metrics" \
--workspace "/subscriptions/{{subscription_id}}/resourceGroups/esdso-rg-ops-re1-ugx/providers/Microsoft.OperationalInsights/workspaces/esdso-log-agency-law-feq" \
--logs "[{category:AutomaticTuning,enabled:true,retention-policy:{enabled:false,days:7}},{category:Blocks,enabled:true,retention-policy:{enabled:false,days:7}},{category:DatabaseWaitStatistics,enabled:true,retention-policy:{enabled:false,days:7}},{category:Deadlocks,enabled:true,retention-policy:{enabled:false,days:7}},{category:DevOpsOperationsAudit,enabled:true,retention-policy:{enabled:false,days:7}},{category:QueryStoreRuntimeStatistics,enabled:true,retention-policy:{enabled:false,days:7}},{category:QueryStoreWaitStatistics,enabled:true,retention-policy:{enabled:false,days:7}},{category:SQLInsights,enabled:true,retention-policy:{enabled:false,days:7}},{category:SQLSecurityAuditEvents,enabled:true,retention-policy:{enabled:false,days:7}},{category:Timeouts,enabled:true,retention-policy:{enabled:false,days:7}},{category:Errors,enabled:true,retention-policy:{enabled:false,days:7}}]" \
--metrics "[{category:Basic,enabled:true,retention-policy:{enabled:false,days:7}},{category:InstanceAndAppAdvanced,enabled:true,retention-policy:{enabled:false,days:7}},{category:WorkloadManagement,enabled:true,retention-policy:{enabled:false,days:7}}]"


# app service

  # app_service = {
  #   name = "operational_logs_and_metrics"

  #   categories = {
  #     log = [
  #       #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
  #       ["AppServiceHTTPLogs", true, false, 0],
  #       ["AppServiceConsoleLogs", true, false, 0],
  #       ["AppServiceAppLogs", true, false, 0],
  #       ["AppServiceAuditLogs", true, false, 0],
  #       ["AppServiceIPSecAuditLogs", true, false, 0],
  #       ["AppServicePlatformLogs", true, false, 0],
  #     ]
  #     metric = [
  #       #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
  #       ["AllMetrics", true, false, 0],
  #     ]
  #   }
  # }

az monitor diagnostic-settings create \
--resource "/subscriptions/{{subscription_id}}/resourceGroups/esdso-rg-webapp-re1-fyj/providers/Microsoft.Web/sites/esdso-app-webapp-dot-net-khq" \
-n "app_service_logs_and_metrics" \
--workspace "/subscriptions/{{subscription_id}}/resourceGroups/esdso-rg-ops-re1-ugx/providers/Microsoft.OperationalInsights/workspaces/esdso-log-agency-law-feq" \
--logs "[{category:AppServiceHTTPLogs,enabled:true,retention-policy:{enabled:false,days:7}},{category:AppServiceConsoleLogs,enabled:true,retention-policy:{enabled:false,days:7}},{category:AppServiceAppLogs,enabled:true,retention-policy:{enabled:false,days:7}},{category:AppServiceAuditLogs,enabled:true,retention-policy:{enabled:false,days:7}},{category:AppServiceIPSecAuditLogs,enabled:true,retention-policy:{enabled:false,days:7}},{category:AppServicePlatformLogs,enabled:true,retention-policy:{enabled:false,days:7}}]" \
--metrics "[{category:AllMetrics,enabled:true,retention-policy:{enabled:false,days:7}}]"

# bastion host
  # bastion_host = {
  #   name = "bastion_host_logs_and_metrics"
  #   categories = {
  #     log = [
  #       # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
  #       ["BastionAuditLogs", true, false, 7],
  #     ]
  #     metric = [
  #       #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
  #       ["AllMetrics", true, false, 7],
  #     ]
  #   }

  # }

# az monitor diagnostic-settings create \
# --resource ????? "/subscriptions/{{subscription_id}}/resourceGroups/esdso-rg-webapp-re1-fyj/providers/Microsoft.Web/sites/esdso-app-webapp-dot-net-khq" \
# -n "bastion_host_logs_and_metrics" \
# --workspace "/subscriptions/{{subscription_id}}/resourceGroups/esdso-rg-ops-re1-ugx/providers/Microsoft.OperationalInsights/workspaces/esdso-log-agency-law-feq" \
# --logs "[{category:BastionAuditLogs,enabled:true,retention-policy:{enabled:false,days:7}}]" \
# --metrics "[{category:AllMetrics,enabled:true,retention-policy:{enabled:false,days:7}}]"

