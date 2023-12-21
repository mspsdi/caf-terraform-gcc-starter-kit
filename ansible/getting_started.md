# Deployment Steps

## table of contents
Deployment can be done via the below environments
1. vs code and docker desktop
2. azure container instance

# 1. deploy environment: vs code and docker desktop

## login to azure - note: ensure dns is 8.8.8.8 

az login --tenant xxxxxxxx-ffda-45c1-adc5-xxxxxxxxxxxx  [tenant id] e.g. htx sandpit xxxxxxxx-ffda-45c1-adc5-xxxxxxxxxxxx

az account set --subscription xxxxxxxx-4066-42f0-b0fa-xxxxxxxxxxxx 

## edit definition files with your subscription id

vi /tf/caf/definition/config_gcc.yaml

## ignite code generation

rover ignite --playbook /tf/caf/ansible/gcc-starter-playbook.yml

sudo chmod -R -f 777 /tf/caf/gcc_starter_ignitexxx_uat

## execute script to run the all rover commands for the landing zone and solution accelerators

cd /tf/caf/gcc_starter_morisuat_uat
./deploy_platform.sh

## check results

# 2. deploy environment: azure container instance

## setup launchpad - create container instance as a platform launchpad

az group create --name ignite-rg-launchpad --location southeastasia

RG_ID="/subscriptions/{{subscription_id}}" # "/subscriptions/xxxxxxxx-4066-42f0-b0fa-xxxxxxxxxxxx"


az container create \
  --name aci-platform-runner \
  --resource-group ignite-rg-launchpad \
  --image aztfmod/rover:1.6.4-2311.2003  \
  --vnet ignite-vnet-am-devops-uat \
  --vnet-address-prefix 192.200.1.96/27 \
  --subnet ignite-snet-aci  \
  --subnet-address-prefix 192.200.1.96/28 \
  --assign-identity --scope $RG_ID \
  --cpu 4 \
  --memory 16 \
  --command-line '"/bin/sh" "-c" "git clone https://github.com/mspsdi/caf-terraform-gcc-starter-kit.git /tf/caf; sudo chmod -R -f 777 /tf/caf/.devcontainer; cd /tf/caf/.devcontainer; ./setup.sh; sudo chmod -R -f 777 /tf/caf/ansible; sudo chmod -R -f 777 /tf/caf/definition; while sleep 1000; do :; done"'


az container show \
  --resource-group ignite-rg-launchpad \
  --name aci-platform-runner

SP_ID=$(az container show \
  --resource-group ignite-rg-launchpad \
  --name aci-platform-runner \
  --query identity.principalId --out tsv)

az container exec \
  --resource-group ignite-rg-launchpad \
  --name aci-platform-runner \
  --exec-command "/bin/zsh"


## login to azure container instance console with zsh terminal
goto azure portal container instance, open the container instance console

## git clone gcc starter kit to /tf/caf folder

git clone https://github.com/mspsdi/caf-terraform-gcc-starter-kit.git /tf/caf

## grant permission for execution

sudo chmod -R -f 777 /tf/caf/.devcontainer
sudo chmod -R -f 777 /tf/caf/ansible
sudo chmod -R -f 777 /tf/caf/definition

## execute setup.sh

cd /tf/caf/.devcontainer
./setup.sh

## login to azure - note: ensure dns is 8.8.8.8 

az login --tenant xxxxxxxx-ffda-45c1-adc5-xxxxxxxxxxxx  [tenant id] e.g. htx sandpit xxxxxxxx-ffda-45c1-adc5-xxxxxxxxxxxx

az account set --subscription xxxxxxxx-4066-42f0-b0fa-xxxxxxxxxxxx 

## edit definition files with your subscription id

vi /tf/caf/definition/config_gcc.yaml

## ignite code generation

rover ignite --playbook /tf/caf/ansible/gcc-starter-playbook.yml

sudo chmod -R -f 777 /tf/caf/gcc_starter_ignitexxx_uat


# OPTIONAL: Create GCC Development Environment
```bash
cd /tf/caf/gcc_starter_ignitexxx_uat/landingzone/configuration/gcc_dev_env

terraform init

terraform plan

terraform apply

cd ..

```
## execute script to run the all rover commands for the landing zone and solution accelerators

cd /tf/caf/gcc_starter_ignitexxx_uat
./deploy_platform.sh

## check results



