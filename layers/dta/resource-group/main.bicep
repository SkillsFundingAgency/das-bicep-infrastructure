targetScope = 'subscription'

param resourceGroup object

module rgModule '../../../modules/resource_group/resourceGroup.bicep' = {
  name: 'createResourceGroup'
  params: {
    resourceGroupName: resourceGroup.name
    resourceGroupLocation: resourceGroup.location
  }
}
