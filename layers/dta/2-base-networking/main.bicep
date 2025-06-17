param config object
param coreRg object
param appTeamRg object


var inflate = config.baseNetworking.inflate

var platformSubnets = config.baseNetworking.platformSubnets
var applicationSubnets = config.baseNetworking.applicationSubnets

// Platform VNET
module platformVnet '../../../modules/networking/az-virtual_network/vnet.bicep' = if (inflate) {
  name: 'platform-vnet'
  params: {
    name: config.baseNetworking.platformVnetName
    location: coreRg.location
    resourceGroupName: coreRg.name
    addressSpace: config.baseNetworking.platformVnetAddressSpace
    tags: config.tags
  }
}

// App Team VNET
module applicationVnet '../../../modules/networking/az-virtual_network/vnet.bicep' = if (inflate) {
  name: 'application-vnet'
  params: {
    name: config.baseNetworking.applicationVnetName
    location: appTeamRg.location
    resourceGroupName: appTeamRg.name
    addressSpace: config.baseNetworking.applicationVnetAddressSpace
    tags: config.tags
  }
}

// Platform Subnets
module platformSubnetsMod '../../../modules/networking/az-subnet/subnet.bicep' = [for subnet in platformSubnets: {
  name: 'platform-subnet-${subnet.subnetName}'
  params: {
    name: subnet.subnetName
    vnetName: config.baseNetworking.platformVnetName
    addressPrefixes: subnet.addressPrefixes
  }
  dependsOn: [platformVnet]
}]

// Application Subnets
module applicationSubnetsMod '../../../modules/networking/az-subnet/subnet.bicep' = [for subnet in applicationSubnets: {
  name: 'application-subnet-${subnet.subnetName}'
  params: {
    name: subnet.subnetName
    vnetName: config.baseNetworking.applicationVnetName
    addressPrefixes: subnet.addressPrefixes
  }
  dependsOn: [applicationVnet]
}]
