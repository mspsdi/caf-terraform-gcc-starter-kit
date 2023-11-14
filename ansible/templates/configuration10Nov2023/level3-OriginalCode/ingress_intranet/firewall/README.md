
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/ingress_intranet/firewall \
-parallelism 30 \
-env uat \
-tfstate networking_firewall_ingress_intranet.tfstate \
-a plan


rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/ingress_intranet/firewall \
-parallelism 30 \
-env uat \
-tfstate networking_firewall_ingress_intranet.tfstate \
-a apply

rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/gcc_starter_escep_uat/landingzone/configuration/level3/ingress_intranet/firewall \
-parallelism 30 \
-env uat \
-tfstate networking_firewall_ingress_intranet.tfstate \
-a destroy


