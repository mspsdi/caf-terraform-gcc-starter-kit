# caf-terraform-gcc-starter-kit
caf terraform accelerator kit for public sector


<!-- BADGES -->
<img src="https://forthebadge.com/images/badges/made-with-javascript.svg" height="30">

<br />

<!-- PROJECT LOGO -->
<p align="center">
    <img src="docs/gcc-starter-kit-icon.png" height="180" width="180"/>
</p>

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Features](#features)
  * [Built With](#built-with)
  * [Overview Architecture](#architecture)
  * [Frontend](#frontend)
  * [Backend](#backend)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Branch](#branch)
* [Versioning](#versioning)
* [License](#license)
* [Contact](#contact)

<!-- ABOUT THE PROJECT -->
## About The Project

<!--
HTX and Microsoft have joined forces to create a Cloud-Based Evidence Platform that can help the Singapore Police Force (SPF) with their investigations. The platform, called Cloud Evidence Platform, is designed to gather open-source intelligence (OSINT) data that is relevant to a crime and transform it into admissible evidence that can support the SPF in investigation and in court. The platform leverages Microsoft's Azure cloud services and artificial intelligence capabilities to collect, analyze, and present OSINT data from various sources, such as social media, online forums, news articles, and public databases. The platform also ensures the integrity, security, and privacy of the data, as well as its compliance with legal and ethical standards. The Cloud Evidence Platform is expected to enhance the efficiency, effectiveness, and accuracy of the SPF's investigations, as well as to reduce the workload and risks for the investigators.
-->

The purpose of the “AZURE GCC Acceleration Kit” is to facilitate the workload setup in AZURE environment. This will be achieved in a two-step layered approach.  
<p align="center">
    <img src="docs/overall-workflow-1.png"/>
</p>

<p align="center">
    <img src="docs/overall-workflow-2.png"/>
</p>


### Features

#### Public Segment

Internet Ingress
- [x] Ingress Fiewall
- [x] Egress Firewall
- [x] Ingress Application Gateway with WAF

Intranet Ingress
- [x] Ingress Fiewall
- [x] Egress Firewall
- [x] Ingress Application Gateway with WAF

#### Private Segment

Project compartment
- [x] AKS private cluster
- [x] Azure Container Registry
- [x] APIM
- [x] App Service
- [x] Container Instance
- [x] Open AI Service
- [x] Cognitive Search Service
- [x] Cosmos DB
- [x] App Service
- [x] SQL Server

Management Compartment
- [x] Bastion Host
- [x] Tooling Windows Server

DevOps Compartment
- [x] Runner Container Instance
- [ ] VPN Gateway


### Work In Progress

- [ ] Acceleration Kit UI 
- [ ] Integration with GitHub
- [ ] One Click deployment

### Built With

<!-- Cloud Evidence Platform (CEP) runs on Microsoft Azure and is built on top of React and NodeJS. It relies on Azure SQL Database and Azure Storage for storage, Azure Communication Services to dispatch e-mails and is deployed on Azure App Service and Azure Function. Optionally, CEP can also talk to Government-hosted systems - SingPass/CorpPass/MyInfo to retrieve form-filler identities, and E-mail servers hosted in Government Data Centres.
-->

- CAF Terraform
- CAF Rover
- Terraform
- Ansible
- Jinja2 template

### Architecture

This section aims to give the reader an overview of GCC Starter architecture
<!-- , relative to external systems and in terms of how the codebase is organised. -->

#### Overview Architecture

<p align="center">
  <img src="docs/gcc-starter-kit-architecture.png">
</p>

### Frontend

WIP
<!--
The frontend of the Cloud Evidence Platform is built using React, a popular JavaScript library for creating user interfaces. React enables the frontend to be fast, responsive, and modular, as well as supporting features such as routing, authentication, and state management. Below is the screenshot from CEP.

<p align="center">
  <img src="docs/Frontend.png">
</p>

### Backend

The Cloud Evidence Platform (CEP) API consists of three distinct functions that handle different aspects of the CEP workflow. 

* The Authentication function verifies the identity and authorization of the users and clients that access the CEP system. 
* The Case Management function manages the creation, update, retrieval and deletion of cases and their associated data. 
* The Job Processing function executes the tasks and rules that are defined for each case and communicates with the CEP Backend.

| API Name | Description |
|:--------------:|----------------------|
| Web API | XXXXX |
| Authentication API | XXXXXX |
| URL Export API | XXXXXX |
| Add Case API | XXXXXX |
| Process Job API | XXXXXX |
-->

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps below.

### Prerequisites

In order to start deploying your environments with CAF landing zones, you need an Azure subscription (Trial, MSDN, etc.) and you need to install the following components on your machine:
* Visual Studio Code
* Docker Desktop or Rancher Desktop in dockerd mode.
* Git
<br/><br/>
#### Git Clone the Repo
```bash
git clone https://github.com/mspsdi/caf-terraform-gcc-starter-kit
```
* Open working folder with Visual Studio Code (Note: Reopen in container when prompt in VS Code)
  * (if required) Install VS Code Extension - Dev Containers
* Add a zsh terminal from VS Code
* Follow the steps in README.md file

<!--
Before you can start running the project, below are tools that you will need to install in your development computers.

* Install [Python](https://www.python.org/downloads/), [Node.js](https://nodejs.org/en/download/), [Git](https://git-scm.com/downloads), [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) and [Azure Function CLI](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=macos%2Cisolated-process%2Cnode-v4%2Cpython-v2%2Chttp-trigger%2Ccontainer-apps&pivots=programming-language-csharp)

* Setup 
    * a [Microsoft Azure Account](https://azure.microsoft.com/en-us/) to build, manage, and monitor your cloud applications and manage your account and billing through the Azure portal.

* Good understanding of Storyboard. 
  - As the Cloud Evidence Platform follows a DevOps lifecycle, I develop based on project backlog.

* Good Knowledge on [Azure Fundamentals](https://docs.microsoft.com/en-us/azure/?product=featured).

-->

### Deployment


#### A. Ignite - code generator


#### A1. edit the below configuration files


/tf/caf/definition/config_application.yaml<br/>
/tf/caf/definition/config_gcc.yaml<br/>
/tf/caf/definition/config_solution_accelerators.yaml


#### check prefix and subscription id

#### A2. execute rover ignite to generate the caf terraform tfvars file
```bash
cd /tf/caf/ansible
rover ignite --playbook /tf/caf/ansible/gcc-starter-playbook.yml
sudo chmod -R -f 777 /tf/caf/{{gcc_starter_project_folder}}
cd /tf/caf
```

#### B. Begin CAF Terraform for GCC

##### Preparation - GCC simulator environment ** OPTIONAL


OPTIONAL - create development environment (only for your own test environment)
go to /tf/caf/{{gcc_starter_project_folder}}/gcc-dev-env/README.md


#### 1. level 0 - launchpad

1.1. launchpad - /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level0/launchpad
```bash
rover -lz /tf/caf/landingzones/caf_launchpad \
  -launchpad \
  -var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level0/launchpad \
  -env {{caf_environment}} \
  -skip-permission-check \
  -a plan
```

#### 2. level 3 - networking


2.1. level 3 - shared services - /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/shared_services
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
  -level level3 \
  -var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/shared_services \
  -parallelism 30 \
  -env {{caf_environment}} \
  -skip-permission-check \
  -tfstate shared_services.tfstate \
  -a plan
```

2.2. level 3 - management - /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_spoke_management
```
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_spoke_management \
-parallelism 30 \
-env {{caf_environment}} \
-tfstate networking_spoke_management.tfstate \
-a plan
```

2.3. level 3 - devops - /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_spoke_devops
```bash
rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_spoke_devops \
-parallelism 30 \
-env {{caf_environment}} \
-tfstate networking_spoke_devops.tfstate \
-a plan
```

2.4. level 3 - hub internet - /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_hub_internet
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_hub_internet \
-env {{caf_environment}} \
-tfstate networking_hub_internet.tfstate \
-a plan
```

2.5. level 3 - hub intranet - /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_hub_intranet
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_hub_intranet \
-env {{caf_environment}} \
-tfstate networking_hub_intranet.tfstate \
-a plan
```

2.6. level 3 - spoke project - /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_spoke_internet
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_spoke_internet \
-env {{caf_environment}} \
-tfstate networking_spoke_internet.tfstate \
-a plan
```

2.7. level 3 - vnet peering - /tf/caf/ansible/templates/configuration/level3/networking_vnet_peering
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/networking_vnet_peering \
-parallelism 30 \
-env {{caf_environment}} \
-tfstate networking_vnet_peering.tfstate \
-a plan
```

#### firewall, application gateway

2.8. egress firewall internet
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/egress_internet/firewall \
-parallelism 30 \
-env {{caf_environment}} \
-tfstate networking_firewall_egress_internet.tfstate \
-a apply
```

2.9. egress firewall intranet
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/egress_intranet/firewall \
-parallelism 30 \
-env {{caf_environment}} \
-tfstate networking_firewall_egress_intranet.tfstate \
-a apply
```

2.10. agw internet
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/ingress_internet/agw \
-env {{caf_environment}} \
-tfstate solution_accelerators_agw_internet_ssl.tfstate \
-a apply
```

2.11. agw intranet
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/ingress_intranet/agw \
-env {{caf_environment}} \
-tfstate solution_accelerators_agw_intranet_ssl.tfstate \
-a apply
```

2.12. ingress firewall internet
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/ingress_internet/firewall \
-parallelism 30 \
-env {{caf_environment}} \
-tfstate networking_firewall_ingress_internet.tfstate \
-a apply
```

2.13. ingress firewall intranet
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level3 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level3/ingress_intranet/firewall \
-parallelism 30 \
-env {{caf_environment}} \
-tfstate networking_firewall_ingress_intranet.tfstate \
-a apply
```

#### 3. level 4 - solution accelerators

##### DevOps, Management Zone

3.1. Management bastion host and tooling server
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level4 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level4/management \
-parallelism 30 \
-env {{caf_environment}} \
-tfstate solution_accelerators_management.tfstate \
-a apply
```

3.2. devops runner vm or container instances
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level4 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level4/devops \
-parallelism 30 \
-env {{caf_environment}} \
-tfstate solution_accelerators_devops.tfstate \
-a apply
```

##### Project

3.3. sql server
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level4 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level4/project/mssql \
-env {{caf_environment}} \
-tfstate solution_accelerators_mssql.tfstate \
-a apply
```

3.4. cosmo db
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level4 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level4/project/cosmosdb \
-env {{caf_environment}} \
-tfstate solution_accelerators_cosmosdb.tfstate \
-a apply
```
3.5 aks and acr
```bash
rover -lz rover -lz /tf/caf/landingzones/caf_solution \
-level level4 \
-var-folder /tf/caf/{{gcc_starter_project_folder}}/landingzone/configuration/level4/project/aks \
-env {{caf_environment}} \
-tfstate solution_accelerators_aks.tfstate \
-a apply
```


#### 4. Testing

4.1. ** OPTIONAL: deploy sample azure-vote application and validation through internet and intranet

4.2. add deny all to app nsg and web nsg

cd /tf/caf/ansible/templates/scripts
../level3_networking.sh

4.3. sql server admin password
Goto keyvault {{project_code}}-kv-mssql secrets to retrieve your sql server admin password


### Branch

#### develop

The develop branch is for testing and staging of all new features, fixes and tests. 
<!-- When the develop branch is stable and functional in the Azure staging-environment `func azure functionapp publish cep-xxx-staging-fx`, we publish the Functions project into Azure for production `func azure functionapp publish cep-xxx-prod-fx`.
-->

<!-- VERSIONING -->
## Versioning

We follow [semantic versioning](https://semver.org/) for all of our builds.

<!-- LICENSE -->
## License

This project is licensed under the [MIT license](#LICENSE.md).



