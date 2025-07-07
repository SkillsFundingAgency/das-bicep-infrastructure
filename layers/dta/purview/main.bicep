targetScope = 'resourceGroup'

param purview object

module purviewModule '../../../modules/purview/purview.bicep' = {
  name: 'deployPurviewAccount'
  params: {
    purviewAccountName: purview.purviewAccountName
    location: purview.location
    managedResourceGroupName: purview.managedResourceGroupName
    skuName: purview.skuName
    skuCapacity: purview.skuCapacity
    publicNetworkAccess: purview.publicNetworkAccess
    managedResourcesPublicNetworkAccess: purview.managedResourcesPublicNetworkAccess
    managedEventHubState: purview.managedEventHubState
  }
}
