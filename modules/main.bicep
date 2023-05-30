param location string = resourceGroup().location

module storageAccounts './storageAccounts.bicep' = [
  for i in range(2): {
    name: '${carlos}finalexam${i + 1}'
    scope: resourceGroup()
    params: {
      kind: 'StorageV2'
      accessTier: 'Hot'
    }
  }
]

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${carlos}-asp'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: '${carlos}-app'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'MYSECRET'
          value: '${{ secrets.MYSECRET }}'
        }
      ]
    }
  }
  condition: deployApp
}
