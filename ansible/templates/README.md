
# run a command
ls -l /etc/
if [ $? -eq 0 ]; then
    echo "Command succeeded"
else
    echo "Command failed"
fi


# starter kit launchpad setup
# 1. Create container group with system-managed identity

# login to tenant - must use this to login
az login --tenant [tenant id] e.g. htx sandpit xxxxxx-ffda-45c1-adc5-xxxxxxxxxxxx

# subscription
az account set --subscription [your subscription id] 

Open cloud-shell through Azure Portal

=======================================================
# Create container group with system-managed identity
========================================================


# image: aztfmod/rover-agent:1.4.6-2307.0508-gitlab
#       or aztfmod/rover:1.5.2-2307.0508



az group create --name ignite-rg-launchpad --location southeastasia

RG_ID="/subscriptions/xxxxxxxx-4066-42f0-b0fa-xxxxxxxxxxxx"

# {{project_code}}-vnet-am-devops-prd - recommended vnet name
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
  --command-line '"/bin/sh" "-c" "while sleep 1000; do :; done"'

# OR   --command-line "tail -f /dev/null"

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

# execute commands line by line

az login --identity

# ** IMPORTANT - set ARM_USE_MSI = true everytime you bring up the zsh terminal
export ARM_USE_MSI=true

# TODO: manually grant OWNER right to aci-gitlab-runner managed identity
# open azure portal, grant OWNER right to container system managed identity "aci-gitlab-runner"

git clone https://github.com/thiamsoontan/caf-gcc-starter-kit-ignite.git

mv /tf/caf/caf-gcc-starter-kit-ignite/definition /tf/caf
mv /tf/caf/caf-gcc-starter-kit-ignite/ansible /tf/caf
mv /tf/caf/caf-gcc-starter-kit-ignite/patches /tf/caf
mv /tf/caf/caf-gcc-starter-kit-ignite/.devcontainer /tf/caf

# prepare the rover containers
sudo chmod -R -f 777 /tf/caf/.devcontainer/setup.sh
cd /tf/caf/.devcontainer
./setup.sh
cd /tf/caf

# manually/patch add computerName="aci-gitlab-runner" to line 673 to use container instance "aci-gitlab-runner"
# vi /tf/rover/functions.sh

sudo chmod -R -f 777 /tf/rover/functions.sh 
cp /tf/caf/patches/rover/functions.sh /tf/rover/functions.sh



=======================================================
# End container group with system-managed identity
========================================================


========================================================
# VPN - point to site VPN
========================================================

az network vnet subnet create -g ignite-rg-launchpad -n GatewaySubnet --vnet-name ignite-vnet-am-devops-uat --address-prefix 192.200.1.112/29

az network public-ip create -g ignite-rg-launchpad -n ignite-pip-gw --allocation-method Dynamic

az network vnet-gateway create --resource-group ignite-rg-launchpad --name ignite-gw-clienttogitlabrunner --public-ip-addresses ignite-pip-gw --vnet ignite-vnet-am-devops-uat --gateway-type Vpn --sku VpnGw1 --vpn-type RouteBased 

az network vnet-gateway show -g ignite-rg-launchpad -n ignite-gw-clienttogitlabrunner -o table

az network public-ip show -n ignite-pip-gw -g ignite-rg-launchpad


# Following command will be used to configure the Address pool and tunnel type.
az network vnet-gateway update -g ignite-rg-launchpad -n ignite-gw-clienttogitlabrunner --address-prefixes 172.18.176.0/26 --client-protocol SSTP

# The following command creates a self-signed root certificate named ‘P2SRootCert’
# using window Powershell
#=====================================================
$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature -Subject “CN=P2SRootCert” -KeyExportPolicy Exportable -HashAlgorithm sha256 -KeyLength 2048 -CertStoreLocation “Cert:\CurrentUser\My” -KeyUsageProperty Sign -KeyUsage CertSign

# if you did not close the old Powershell window, type the following command, The client certificate will be automatically installed in ‘Certificates – Current User\Personal\Certificates’ on your computer.
New-SelfSignedCertificate -Type Custom -DnsName P2SChildCert -KeySpec Signature -Subject “CN=P2S ChildCert” -KeyExportPolicy Exportable -HashAlgorithm sha256 -KeyLength 2048 -CertStoreLocation “Cert:\CurrentUser\My” -Signer $cert -TextExtension @(“2.5.29.37={text}1.3.6.1.5.5.7.3.2”)

# Export the root certificate public key (.cer):

# After creating a self-signed root certificate, we will export the root certificate public key .cer file (not the private key). we will later upload this file to Azure. Following steps will help you export the .cer file for your self-signed root certificate:
# First find the Thumb Print of Certificate:

Get-ChildItem -Path Cert:\CurrentUser\My\ -recurse

Thumbprint                                Subject
----------                                -------
>> 65BF70A3A74B2BD85C4F6F4AC8A63662868BA99E  CN=P2SRootCert
>> 207F04CCBF63CE662767B7030E0FBE85BE83773A  CN=P2S ChildCert

#Next export to in a .cer file

$cert = (Get-ChildItem -Path cert:\CurrentUser\My\65BF70A3A74B2BD85C4F6F4AC8A63662868BA99E)

Export-Certificate -Cert $cert -FilePath c:\root.cer

The above Export-Certificate cmdlet does not offer the “Base-64 encoded X.509 (.CER)” type to be exported so we need to run the following command.

cd c:\windows\system32

.\certutil.exe -encode c:\root.cer c:\base64cert.cer



# Now we can upload the .cer file (which contains the public key information) for a trusted root certificate to Azure. Once a.cer file is uploaded, Azure can use it to authenticate clients that have installed a client certificate generated from the trusted root certificate. The following command will be used to upload .Cer file
# using zsh terminal
#=====================================================

# copy the two cert into rover cert folder /tf/caf/cert/base64cert.cer

az network vnet-gateway root-cert create -g ignite-rg-launchpad -n P2SRootCert --gateway-name ignite-gw-clienttogitlabrunner --public-cert-data "/tf/caf/cert/base64cert.cer"



# Powershell
======================================================
# Following command will be used to export Cert in .pfx file with Password “abc123”

$mypwd = ConvertTo-SecureString -String “abc123” -Force -AsPlainText
Get-ChildItem -Path cert:\currentuser\my\207F04CCBF63CE662767B7030E0FBE85BE83773A | Export-PfxCertificate -FilePath C:\mypfx.pfx -Password $mypwd


$mypwd = Get-Credential -UserName ‘Enter password below’ -Message ‘Enter password below’
# a dialog box will apprear type the certificate password “abc123”

# type very next command to import the PFX file my.pfx with a private non-exportable key into the My store for the Current User.
Import-PfxCertificate -FilePath C:\mypfx.pfx -CertStoreLocation Cert:\currentuser\My -Password $mypwd.Password


# zsh termianl
# to download VPN client, type following: (or download from Azure Portal "ignite-gw-clienttogitlabrunner | Point-to-site configuration")

az network vnet-gateway vpn-client generate --resource-group ignite-rg-launchpad --name ignite-gw-clienttogitlabrunner --processor-architecture Amd64

========================================================
# End VPN - point to site VPN
========================================================

Reference: 
https://github.com/Azure/caf-terraform-landingzones-accelerator

# GCC Starter Kit - scenario H-Model

The H-Model scenario is designed to demonstrate a basic functional foundations to store Terraform state on Azure storage and use it centrally.
The focus of this scenario is to be able to deploy a basic launchpad from a remote machine and use the portal to review the settings in a non-constrained environment.
For example in this scenario you can go to the Key Vaults and view the secrets from the portal, a feature that is disabled in the 300+ scenarios.
We recommend using the 100 scenario for demonstration purposes.

An estimated time of 5 minutes is required to deploy this scenario.

## Pre-requisites

This scenario require the following privileges:

| Component          | Privileges         |
|--------------------|--------------------|
| Active Directory   | None               |
| Azure subscription | Subscription owner |

## Deployment

1. go to ansible folder
```bash
cd ansible
```
2. generate level0, level3 and level4 tfvars files for gcc starter
```bash
ansible-playbook gcc-starter-playbook.yml  


# rover ignite \
#   --playbook /tf/caf/landingzones/templates/platform/ansible.yaml \
#   -e base_templates_folder=/tf/caf/landingzones/templates/platform \
#   -e resource_template_folder=/tf/caf/landingzones/templates/resources \
#   -e config_folder=/tf/caf/definitions/single_reuse/platform \
#   -e landingzones_folder=/tf/caf/landingzones

```

3. Optional:  if deploy at Azure commerical cloud - create GCC simulator development environment in Azure
```bash
chmod +x /tf/caf/gcc_starter/scripts/deploy_dev_env.sh
/tf/caf/gcc_starter/scripts/deploy_dev_env.sh 
```

4. Deploy gcc starter landingzone and solution accelerators
```bash
chmod +x /tf/caf/gcc_starter/scripts/deploy_gcc_starter.sh
/tf/caf/gcc_starter/scripts/deploy_gcc_starter.sh 
```


## Architecture diagram
![GCC Starter Kit H-Model](../../documentation/img/GCC-Starter-Kit-H-Model.PNG)
![GCC Starter Kit U@App-Model](../../documentation/img/GCC-Starter-Kit-U@-Model.PNG)
![GCC Starter Kit I-Model](../../documentation/img/GCC-Starter-Kit-I-Model.PNG)
![GCC Starter Kit U@DB-Model](../../documentation/img/GCC-Starter-Kit-U@DB-Model.PNG)
??? ![GCC Starter Kit T-Model](../../documentation/img/GCC-Starter-Kit-I-Model.PNG)
??? ![GCC Starter Kit N-Model](../../documentation/img/GCC-Starter-Kit-I-Model.PNG)


## Services deployed in this scenario
| Component             | Purpose                                                                                                                                                                                                                    |
|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Resource group        | Multiple resource groups are created to isolate the services.                                                                                                                                                              |
| Storage account       | A storage account for remote tfstate management is provided for each level of the framework. Additional storage accounts are created for diagnostic logs.                                                                  |
| Key Vault             | The launchpad Key Vault hosts all secrets required by the rover to access the remote states, the Key Vault policies are created allowing the logged-in user to see secrets created and stored.                             |
| Virtual network       | To secure the communication between the services a dedicated virtual network is deployed with a gateway subnet, bastion service, jumpbox and azure devops release agents. Service endpoints is enabled but not configured. |
| Azure AD Applications | An Azure AD application is created. This account is mainly use to bootstrap the services during the initialization. It is also considered as a breakglass account for the launchpad landing zones  