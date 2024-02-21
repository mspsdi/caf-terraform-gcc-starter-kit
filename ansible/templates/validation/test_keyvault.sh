
# managed identity
az login --identity

# get the object id of container instance or app service managed identity or user managed identity through UI
# e.g. 
object_id="aa179867-d7f0-4f87-ae82-51ded479be87"
keyvault_name="kv-shared-kv1-jkq"

# grant container instance to key vault access policy
# az keyvault set-policy --name kv-shared-kv1-jkq --object-id "aa179867-d7f0-4f87-ae82-51ded479be87" --secret-permissions get 
az keyvault set-policy --name ${keyvault_name} --object-id "${object_id}" --secret-permissions get 

# get token
token=$(curl -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true | awk -F"[{,\":}]" '{print $6}')

# using curl to get the secret
# curl -s "https://kv-shared-kv1-jkq.vault.azure.net/secrets/sqlsecret?api-version=2016-10-01" -H "Authorization: Bearer ${token}"
curl -s "https://${keyvault_name}.vault.azure.net/secrets/sqlsecret?api-version=2016-10-01" -H "Authorization: Bearer ${token}"


