targetScope = 'resourceGroup'

param apim object

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' existing = {
  name: apim.vnetName
}

resource apimSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' existing = {
  parent: vnet
  name: apim.apimSubnetName
}

module apimModule '../../../modules/apim/apim.bicep' = {
  name: 'deployApim'
  params: {
    name: apim.apimName
    location: apim.location
    skuName: apim.apimSkuName
    skuCapacity: apim.apimSkuCapacity
    publisherEmail: apim.apimPublisherEmail
    publisherName: apim.apimPublisherName
    subnetResourceId: apimSubnet.id
  }
}
