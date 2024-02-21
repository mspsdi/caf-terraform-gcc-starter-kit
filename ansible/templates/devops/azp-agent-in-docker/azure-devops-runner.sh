
## setup devops launchpad - create container instance as a platform launchpad

az group create --name ss-rg-azuredevops --location southeastasia

# {{subscription_id}}" # "/subscriptions/xxxxxxxx-4066-42f0-b0fa-xxxxxxxxxxxx"
RG_ID="/subscriptions/{{subscription_id}}"

# env variables
AZP_URL="{{enter azure devops organisation url}}" 
AZP_TOKEN="{{enter azp token}}"
AZP_AGENT_NAME="Docker Agent - Linux"
AZP_POOL="docker-agent-linux"
AZP_WORK="_work"


# container image - docker hub - already available - DO NOT CHANGE
# this image is baked with azure devops agent start.sh script
CONTAINER_IMAGE_NAME="thiamsoontan/azp-agent:latest"

# create container instance for the devops runner agent
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
  --environment-variables 'AZP_URL'='{{enter azure devops organisation url}}' 'AZP_TOKEN'='{{enter azp token}}' 'AZP_AGENT_NAME'='Docker Agent - Linux' 'AZP_POOL'='docker-agent-linux' 'AZP_WORK'='_work'

