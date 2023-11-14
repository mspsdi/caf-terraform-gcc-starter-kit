

rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/networking_hub_intranet \
-env uat \
-tfstate networking_hub_intranet.tfstate \
-a plan


rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/networking_hub_intranet \
-env uat \
-tfstate networking_hub_intranet.tfstate \
-a apply

rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/networking_hub_intranet \
-env uat \
-tfstate networking_hub_intranet.tfstate \
-a destroy

 


