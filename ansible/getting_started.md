
# GCC Starter Kit - scenario H-Model

The H-Model scenario is designed to demonstrate a basic functional foundations to store Terraform state on Azure storage and use it centrally.
The focus of this scenario is to be able to deploy a basic launchpad from a remote machine and use the portal to review the settings in a non-constrained environment.
For example in this scenario you can go to the Key Vaults and view the secrets from the portal, a feature that is disabled in the 300+ scenarios.
We recommend using the 100 scenario for demonstration purposes.

An estimated time of 120 minutes is required to deploy this scenario.

## Pre-requisites

This scenario require the following privileges:

| Component          | Privileges         |
|--------------------|--------------------|
| Active Directory   | None               |
| Azure subscription | Subscription owner |

Agency GCC Environment 

| Azure Resource                                  | Privileges         |
|-------------------------------------------------|--------------------|
| VNet-Ingress/Egress                             | None               |
| VNet-Project Internet                           | None               |
| VNet-Project Intranet                           | None               |
| VNet-Management                                 | None               |
| VNet-DevOps                                     | None               |
| Internet Ingress - Azure Firewall               | None               |
| Internet Web Tier - Application Gateway         | None               |
| Internet App Tier - AKS                         | None               |
| Internet DB Tier - MSSQL                        | None               |
| Internet IT Tier - APIM                         | None               |
| Internet GUT Tier - VM for Forward Proxy        | None               |
| Intranet Web Tier - Application Gateway         | None               |
| Intranet App Tier - AKS                         | None               |
| Intranet DB Tier - MSSQL                        | None               |
| Intranet IT Tier - APIM                         | None               |
| Intranet GUT Tier - VM for Forward Proxy        | None               |
| Management Zone - VM for Tooling Server         | None               |
| DevOps Zone - VM for Runner/Agent + A           | None               |

Verify and update the config.yaml file


## Deployment

1. Go to ansible folder
```bash
cd ansible
```
2. Generate level0, level3 and level4 tfvars files of GCC Starter Kit
```bash
ansible-playbook gcc-starter-playbook.yml  
rover ignite --playbook /tf/caf/ansible/gcc-starter-playbook.yml

```

3. Optional: if deploy at Azure commerical cloud run the below bash command to create GCC simulator development environment in Azure
```bash
/tf/caf/gcc_starter/scripts/deploy_dev_env.sh 
```

4. Deploy gcc starter landingzone and solution accelerators
```bash
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