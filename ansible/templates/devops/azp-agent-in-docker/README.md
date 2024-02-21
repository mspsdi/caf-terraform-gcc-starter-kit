
# login to azure devops to create a agent pool
# menu: <organisation_url>/<project>/Settings/Agent pools/docker-agent-linux

AZP_POOL="docker-agent-linux"

# create a azure devops AZP token
# menu: https://dev.azure.com/<organisation_url>/_usersSettings/tokens
# click on New Token
cd /tf/caf/azure_devops/azp-agent-in-docker

# Run the following command within that directory:
# The final image is tagged azp-agent:linux.
docker build --tag "azp-agent:linux" --file "./azp-agent-linux.dockerfile" .

# tag image and push to dockerhub
docker image tag azp-agent:linux xxxxxxxxxxxxx/azp-agent:latest
docker push xxxxxxxxxxxxx/azp-agent:latest


## setup devops launchpad - create container instance as a platform launchpad

az group create --name ss-rg-azuredevops --location southeastasia

# {{subscription_id}}" # "/subscriptions/xxxxxxxx-4066-42f0-b0fa-xxxxxxxxxxxx"
RG_ID="/subscriptions/xxxxxxxx-4066-42f0-b0fa-xxxxxxxxxxxx"

# env variables
AZP_URL="https://dev.azure.com/xxxxx" 
AZP_TOKEN="xxxxxxxxxxxxxdwncirrc2gnljk3jud6de7ligzdyxxxxxxxxxxxxx"

AZP_AGENT_NAME="Docker Agent - Linux"
AZP_POOL="docker-agent-linux"
AZP_WORK="_work"


# container image - docker hub - already available
CONTAINER_IMAGE_NAME="xxxxxxxxxxxxx/azp-agent:latest"

# container create
az container create \
  --name aci-platform-runner1 \
  --resource-group ss-rg-azuredevops \
  --image "$CONTAINER_IMAGE_NAME" \
  --vnet ss-vnet-am-devops-uat \
  --vnet-address-prefix 192.200.1.96/27 \
  --subnet ss-snet-aci  \
  --subnet-address-prefix 192.200.1.96/28 \
  --assign-identity --scope $RG_ID \
  --cpu 4 \
  --memory 16 \
  --command-line '"/bin/sh" "-c" "while sleep 1000; do :; done"' \
  --environment-variables 'AZP_URL'='https://dev.azure.com/xxxxx' 'AZP_TOKEN'='xxxxxxxxxxxxxdwncirrc2gnljk3jud6de7ligzdyxxxxxxxxxxxxx' 'AZP_AGENT_NAME'='Docker Agent - Linux' 'AZP_POOL'='docker-agent-linux' 'AZP_WORK'='_work'



