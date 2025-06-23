targetScope = 'resourceGroup'

param location string
param purviewAccountName string
param managedResourceGroupName string
param skuName string = 'Standard'
param skuCapacity int = 1
param publicNetworkAccess string = 'Enabled'
param managedResourcesPublicNetworkAccess string = 'Enabled'
param managedEventHubState string = 'Enabled'

module purviewModule '../../../modules/purview/purview.bicep' = {
  name: 'deployPurviewAccount'
  params: {
    purviewAccountName: purviewAccountName
    location: location
    managedResourceGroupName: managedResourceGroupName
    skuName: skuName
    skuCapacity: skuCapacity
    publicNetworkAccess: publicNetworkAccess
    managedResourcesPublicNetworkAccess: managedResourcesPublicNetworkAccess
    managedEventHubState: managedEventHubState
  }
}
