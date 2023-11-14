
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_vnets \
-env {{caf_environment}} \
-tfstate networking_vnets.tfstate \
-a plan

rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_vnets \
-env {{caf_environment}} \
-tfstate networking_vnets.tfstate \
-a apply

rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_vnets \
-env {{caf_environment}} \
-tfstate networking_vnets.tfstate \
-a destroy
