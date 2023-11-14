# *** Azure Cli command - execute after all azure resources are created with CAF Terraform ***

# 1. app tier inbound deny all
# cli sample: az network nsg rule create -g MyResourceGroup --nsg-name MyNsg -n MyNsgRule --priority 4096 --source-address-prefixes 208.130.28.0/24 --source-port-ranges 80 --destination-address-prefixes '*' --destination-port-ranges 80 8080 --access Deny --protocol Tcp --description "Deny from specific IP address ranges on 80 and 8080."  --direction Inbound
```bash
az network nsg rule create -g {{project_code}}-rg-networking-spoke-internet-re1 --nsg-name {{project_code}}-nsg-app -n DenyAllInboundRule --priority 4096 --source-address-prefixes '*' --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges '*' --access Deny --protocol '*' --description "Deny Inbound from all IP address ranges on all ports." --direction Inbound
```

# 2. app tier outbound deny all
```bash
az network nsg rule create -g {{project_code}}-rg-networking-spoke-internet-re1 --nsg-name {{project_code}}-nsg-app -n DenyAllOutboundRule --priority 4096 --source-address-prefixes '*' --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges '*' --access Deny --protocol '*' --description "Deny Outbound from all IP address ranges on all ports." --direction Outbound
```

# 3. During AKS upgrade, remove the DenyAllInboundRule and DenyAllOutboundRule
```bash
az network nsg rule delete -g {{project_code}}-rg-networking-spoke-internet-re1 --nsg-name {{project_code}}-nsg-app -n DenyAllInboundRule
az network nsg rule delete -g {{project_code}}-rg-networking-spoke-internet-re1 --nsg-name {{project_code}}-nsg-app -n DenyAllOutboundRule
```

# 4. grant reader, network contributor to virtual network

az role assignment create --assignee "55555555-5555-5555-5555-555555555555" \
--role "Storage Blob Data Contributor" \
--scope "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/Example-Storage-rg/providers/Microsoft.Storage/storageAccounts/storage12345"
