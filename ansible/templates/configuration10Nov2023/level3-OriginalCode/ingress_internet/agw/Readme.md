
# ** to manually remove agw and firewall, make sure remove the log and seeting from diagnostic seeting first 
# before the whole resource group

rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/ingress_internet/agw \
-env uat \
-tfstate solution_accelerators_agw_internet_ssl.tfstate \
-a plan


rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/ingress_internet/agw \
-env uat \
-tfstate solution_accelerators_agw_internet_ssl.tfstate \
-a apply

rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/ingress_internet/agw \
-env uat \
-tfstate solution_accelerators_agw_internet_ssl.tfstate \
-a destroy
