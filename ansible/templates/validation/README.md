# ensure has access to mcr
# ssh into rover runner
# deploy sample apps
# https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-cli

vi azure-vote.yaml

# copy and paste content of "/tf/caf/gcc_starter_kit/validation/sample-app-internal-lb.yaml" into azure-vote.yaml

# sandpit tenant - must use this to login
az login --tenant [your tenant id] # htx sandpit - xxxxxx-ffda-45c1-adc5-xxxxxxxxxxxx

# CEP subscription
az account set --subscription [your subscription id] # cep - xxxxxxxx-4066-42f0-b0fa-xxxxxxxxxxxx

# sample: az aks get-credentials --resource-group ignite-rg-aks --name ignite-aks
# get aks credentials
az aks get-credentials --resource-group escep-rg-aks-re1 --name escep-aks-cluster-re1

# **IMPORTANT 
# TODO: 
# 1. link the aks private DNS to devops vnet, else will not be able to find AKS private cluster.
# 2. Grant netwrok contributor and reader to gcci-vnet-internet vnet to allow creation of internal load balancer
# virtual network: /subscriptions/xxxxxxxx-4066-42f0-b0fa-xxxxxxxxxxxx/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet
# permission: Reader and Network Contributor
ERROR:
''' BASH
Error syncing load balancer: failed to ensure load balancer: Retriable: false, RetryAfter: 0s, HTTPStatusCode: 403, RawError: {"error":{"code":"AuthorizationFailed","message":"The client '3448bfd3-5774-4682-a10a-cab46df1e337' with object id '3448bfd3-5774-4682-a10a-cab46df1e337' does not have authorization to perform action 'Microsoft.Network/virtualNetworks/subnets/read' over scope '/subscriptions/xxxxxxxx-4066-42f0-b0fa-xxxxxxxxxxxx/resourceGroups/gcci-platform/providers/Microsoft.Network/virtualNetworks/gcci-vnet-internet/subnets/ignite-snet-app-internet' or the scope is invalid. If access was recently granted, please refresh your credentials."}}
'''
Resolution:
Grant "reader" and "network contributor" to managed identity "ignite-msi-aks-usermsi" (object id: 3448bfd3-5774-4682-a10a-cab46df1e337) to vnet "ignite-snet-app-internet"
Grant "reader" and "network contributor" to xxx-aks-cluster-re1 resources (object id: 3448bfd3-5774-4682-a10a-cab46df1e337) to vnet "ignite-snet-app-internet"

Reference: https://learn.microsoft.com/en-us/answers/questions/720289/i-am-unable-to-spin-up-internal-load-balancers-in
# Note the load balancer will take about 2 minutes to create.


# deploy the container into aks
kubectl apply -f azure-vote.yaml

# remove the container into aks
kubectl delete -f azure-vote.yaml

Issue:
1. Ensure age port 80 is the listener (private) if http or 443 is using private listener if https

# other kubectl commands
kubectl get pods
kubectl get services
kubectl get events


# sql commands

sqlcmd -S <server_name> -U <username> -P <password>

CREATE DATABASE <database_name>;

USE <database_name>;

Create Table: The general syntax for creating a table is:

CREATE TABLE table_name (column1 datatype, column2 datatype, ...);
For example, to create a table named Students, enter the following command:

CREATE TABLE Students (StudentId int, StudentName nvarchar(50), StudentAge int);




openssl genrsa -out moris-uat.gra.gov.sg key 2048 


openssl pkcs12 -export -out certificate.pfx -inkey privateKey.key -in certificate.crt -certfile CACert.crt

openssl pkcs12 -export -out domain.pfx -inkey domain.key -in domain.crt


# step to create a self sign certificate - domain.pfx
---------------------------------------------------------------------------------------
➜  caf openssl genrsa -des3 -out domain.key 2048
Enter PEM pass phrase:
Verifying - Enter PEM pass phrase:
➜  caf openssl req -key domain.key -new -out domain.csr
Enter pass phrase for domain.key:
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:SG
State or Province Name (full name) [Some-State]:
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:!qaz@wsx@1234567890
An optional company name []:GRA
➜  caf openssl req -key domain.key -new -x509 -days 365 -out domain.crt
Enter pass phrase for domain.key:
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:SG
State or Province Name (full name) [Some-State]:SG
Locality Name (eg, city) []:SG
Organization Name (eg, company) [Internet Widgits Pty Ltd]:GRA
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:moris-uat.gra.gov.sg
Email Address []:kianpoh@gra.gov.sg
➜  caf openssl pkcs12 -export -out domain.pfx -inkey domain.key -in domain.crt
Enter pass phrase for domain.key:
Enter Export Password:
Verifying - Enter Export Password:
 
