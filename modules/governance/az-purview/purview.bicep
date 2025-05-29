param name string
param location string
param resourceGroupName string
param tags object
param managedResourceGroupName string
param skuName string = 'Standard'

resource purview 'Microsoft.Purview/accounts@2021-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    publicNetworkAccess: 'Enabled'
    managedResourceGroupName: managedResourceGroupName
  }
  sku: {
    name: skuName
  }
}
