
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/ingress_intranet/agw \
-env uat \
-tfstate solution_accelerators_agw_intranet_ssl.tfstate \
-a plan


rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/ingress_intranet/agw \
-env uat \
-tfstate solution_accelerators_agw_intranet_ssl.tfstate \
-a apply

rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/ingress_intranet/agw \
-env uat \
-tfstate solution_accelerators_agw_intranet_ssl.tfstate \
-a destroy
