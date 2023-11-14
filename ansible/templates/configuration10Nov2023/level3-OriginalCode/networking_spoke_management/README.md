
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/networking_spoke_management \
-parallelism 30 \
-env uat \
-tfstate networking_spoke_management.tfstate \
-a plan

rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/networking_spoke_management \
-parallelism 30 \
-env uat \
-tfstate networking_spoke_management.tfstate \
-a apply

rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/networking_spoke_management \
-parallelism 30 \
-env uat \
-tfstate networking_spoke_management.tfstate \
-a destroy


