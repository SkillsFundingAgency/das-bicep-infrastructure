targetScope = 'resourceGroup'

param network object

module vnetModule '../../../modules/network/vnet.bicep' = {
  name: 'deployVnet'
  params: {
    vnetName: network.vnetName
    location: network.location
    addressSpace: network.addressSpace
  }
}

module vmSubnetModule '../../../modules/network/subnet.bicep' = {
  name: 'deployVmSubnet'
  params: {
    subnetName: network.vmSubnetName
    addressPrefix: network.vmSubnetPrefix
    vnetName: network.vnetName
  }
  dependsOn: [
    vnetModule
  ]
}

module apimSubnetModule '../../../modules/network/subnet.bicep' = {
  name: 'deployApimSubnet'
  params: {
    subnetName: network.apimSubnetName
    addressPrefix: network.apimSubnetPrefix
    vnetName: network.vnetName
  }
  dependsOn: [
    vnetModule
  ]
}

module FirewallSubnetModule '../../../modules/network/subnet.bicep' = {
  name: 'deployFirewallSubnet'
  params: {
    subnetName: network.FirewallSubnetName
    addressPrefix: network.FirewallSubnetPrefix
    vnetName: network.vnetName
  }
  dependsOn: [
    vnetModule
  ]
}

module appGatewaySubnetModule '../../../modules/network/subnet.bicep' = {
  name: 'deployAppGatewaySubnet'
  params: {
    subnetName: network.appGatewaySubnetName
    addressPrefix: network.appGatewaySubnetPrefix
    vnetName: network.vnetName
  }
  dependsOn: [
    vnetModule
  ]
}

module AppGatewayPublicIpModule '../../../modules/network/public-ip.bicep' = {
  name: 'deployAppGatewayPublicIp'
  params: {
    pipName: network.AppGatewayPublicIpName
    location: network.location
    sku: network.AppGatewayPublicIpSku
  }
}

module vmPublicIpModule '../../../modules/network/public-ip.bicep' = {
  name: 'deployVmPublicIp'
  params: {
    pipName: network.vmPublicIpName
    location: network.location
    sku: network.vmPublicIpSku
  }
}

module vmNetworkSecurityGroupModule '../../../modules/network/nsg.bicep' = {
  name: 'deployVmNsg'
  params: {
    name: network.networkSecurityGroup.name
    location: network.location
    securityRules: network.networkSecurityGroup.securityRules
  }
}

module vmNicModule '../../../modules/network/nic.bicep' = {
  name: 'deployVmNic'
  params: {
    nicName: network.vmNic.name
    location: network.location
    subnetId: resourceId('Microsoft.Network/virtualNetworks/subnets', network.vnetName, network.vmSubnetName)
    privateIPAllocationMethod: network.vmNic.privateIPAllocationMethod
    networkSecurityGroupId: resourceId('Microsoft.Network/networkSecurityGroups', network.networkSecurityGroup.name)
    publicIpId: resourceId('Microsoft.Network/publicIPAddresses', network.vmPublicIpName)
  }
  dependsOn: [
    vmPublicIpModule
    vmSubnetModule
    vmNetworkSecurityGroupModule
  ]
}

module routeTableModule '../../../modules/network/route-table.bicep' = {
  name: 'deployRouteTable'
  params: {
    name: network.routeTable.name
    location: network.location
    disableBgpRoutePropagation: network.routeTable.disableBgpRoutePropagation
    routes: network.routeTable.routes
  }
}
