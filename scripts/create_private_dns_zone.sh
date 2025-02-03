# Description: Create a private DNS zone in Azure
# Reference: https://learn.microsoft.com/en-us/azure/dns/private-dns-getstarted-cli

# create vnet
az network vnet create \
  --name myAzureVNet \
  --resource-group MyAzureResourceGroup \
  --location eastus \
  --address-prefix 10.2.0.0/16 \
  --subnet-name backendSubnet \
  --subnet-prefixes 10.2.0.0/24
# create private dns zone
az network private-dns zone create -g MyAzureResourceGroup \
   -n private.contoso.com
# create link
az network private-dns link vnet create -g MyAzureResourceGroup -n MyDNSLink \
   -z private.contoso.com -v myAzureVNet -e true
# create record
az network private-dns record-set a add-record -g MyAzureResourceGroup \
   -z private.contoso.com -n www -a
# list zones
az network private-dns zone list -g MyAzureResourceGroup
# list records
az network private-dns zone list -g MyAzureResourceGroup \
   --query "[].{Name:name, ResourceGroup:resourceGroup, ProvisioningState:provisioningState}" \
   --output table
