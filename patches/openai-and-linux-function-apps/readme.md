
# module folder - linux function app
cp  /tf/caf/patches/openai-and-linux-function-apps/linux_function_app /tf/caf/landingzones/aztfmod/modules/webapps/linux_function_app
cp /tf/caf/patches/openai-and-linux-function-apps/cognitive_deployment /tf/caf/landingzones/aztfmod/modules/cognitive_services/cognitive_deployment
cp /tf/caf/patches/openai-and-linux-function-apps/cognitive_services_account /tf/caf/landingzones/aztfmod/modules/cognitive_services/cognitive_services_account
cp /tf/caf/patches/openai-and-linux-function-apps/search_service /tf/caf/landingzones/aztfmod/modules/cognitive_services/search_service

# caf_solution
cp /tf/caf/patches/openai-and-linux-function-apps/caf_solution/local.webapp.tf /tf/caf/landingzones/caf_solution/local.webapp.tf
cp /tf/caf/patches/openai-and-linux-function-apps/caf_solution/variables.webapp.tf /tf/caf/landingzones/caf_solution/variables.webapp.tf

/tf/caf/patches/openai-and-linux-function-apps/caf_solution/local.cognitive_services.tf /tf/caf/landingzones/caf_solution/local.cognitive_services.tf
/tf/caf/patches/openai-and-linux-function-apps/caf_solution/variables.cognitive_services.tf  /tf/caf/landingzones/caf_solution/variables.cognitive_services.tf

# aztfmod
cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/linux_function_apps.tf /tf/caf/landingzones/aztfmod/linux_function_app.tf
cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/cognitive_deployments.tf /tf/caf/landingzones/aztfmod/cognitive_deployments.tf
cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/cognitive_search_services.tf /tf/caf/landingzones/aztfmod/cognitive_search_services.tf
cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/cognitive_service.tf  /tf/caf/landingzones/aztfmod/cognitive_service.tf

cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/locals.tf /tf/caf/landingzones/aztfmod/locals.tf
cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/locals.combined_objects.tf /tf/caf/landingzones/aztfmod/locals.combined_objects.tf
cp /tf/caf/patches/openai-and-linux-function-apps/aztfmod/local.remote_objects.tf /tf/caf/landingzones/aztfmod/local.remote_objects.tf


