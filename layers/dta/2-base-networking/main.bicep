param config object
param coreRg object
param appTeamRg object

var inflate = config.baseNetworking.inflate

var platformSubnets = config.baseNetworking.platformSubnets
var applicationSubnets = config.baseNetworking.applicationSubnets

// Platform VNET
module platformVnet 'modules/az-virtual-network.bicep' = if (inflate) {
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
module applicationVnet 'modules/az-virtual-network.bicep' = if (inflate) {
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
module platformSubnetsMod 'modules/az-subnet.bicep' = [for subnet in platformSubnets: {
  name: 'platform-subnet-${subnet.subnetName}'
  params: {
    name: subnet.subnetName
    resourceGroupName: coreRg.name
    vnetName: config.baseNetworking.platformVnetName
    addressPrefixes: subnet.addressPrefixes
  }
  dependsOn: [platformVnet]
}]

// Application Subnets
module applicationSubnetsMod 'modules/az-subnet.bicep' = [for subnet in applicationSubnets: {
  name: 'application-subnet-${subnet.subnetName}'
  params: {
    name: subnet.subnetName
    resourceGroupName: appTeamRg.name
    vnetName: config.baseNetworking.applicationVnetName
    addressPrefixes: subnet.addressPrefixes
  }
  dependsOn: [applicationVnet]
}]
