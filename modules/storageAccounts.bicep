param kind string
param accessTier string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: '${carlos}'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: kind
  properties: {
    accessTier: accessTier
  }
}

output storageAccountName string = storageAccount.name
output storageAccountPrimaryBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob
