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

module AppGatewaySubnetModule '../../../modules/network/subnet.bicep' = {
  name: 'deployAppGatewaySubnet'
  params: {
    subnetName: network.AppGatewaySubnetName
    addressPrefix: network.AppGatewaySubnetPrefix
    vnetName: network.vnetName
  }
  dependsOn: [
    vnetModule
  ]
}

module FirewallPublicIpModule '../../../modules/network/public-ip.bicep' = {
  name: 'deployFirewallPublicIp'
  params: {
    pipName: network.FirewallPublicIpName
    location: network.location
    sku: network.FirewallPublicIpSku
  }
}

module AppGatewayPublicIpModule '../../../modules/network/public-ip.bicep' = {
  name: 'deployAppGatewayPublicIp'
  params: {
    pipName: network.AppGatewayPublicIpName
    location: network.location
    sku: network.AppGatewayPublicIpSku
  }
}

module PrivateLinkService '../../../modules/network/public-ip.bicep' = {
  name: 'deployAppGatewayPublicIp'
  params: {
    pipName: network.AppGatewayPublicIpName
    location: network.location
    sku: network.AppGatewayPublicIpSku
  }
}

