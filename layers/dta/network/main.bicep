targetScope = 'resourceGroup'

param location string
param vnetName string
param addressSpace array
param FirewallSubnetName string
param FirewallSubnetPrefix string
param AppGatewaySubnetName string
param AppGatewaySubnetPrefix string
param FirewallPublicIpName string
param FirewallPublicIpSku string
param AppGatewayPublicIpName string
param AppGatewayPublicIpSku string


module vnetModule '../../../modules/network/vnet.bicep' = {
  name: 'deployVnet'
  params: {
    vnetName: vnetName
    location: location
    addressSpace: addressSpace
  }
}


module FirewallSubnetModule '../../../modules/network/subnet.bicep' = {
  name: 'deployFirewallSubnet'
  params: {
    subnetName: FirewallSubnetName
    addressPrefix: FirewallSubnetPrefix
    vnetName: vnetName
  }
  dependsOn: [
    vnetModule
  ]
}

module AppGatewaySubnetModule '../../../modules/network/subnet.bicep' = {
  name: 'deployAppGatewaySubnet'
  params: {
    subnetName: AppGatewaySubnetName
    addressPrefix: AppGatewaySubnetPrefix
    vnetName: vnetName
  }
  dependsOn: [
    vnetModule
  ]
}

module FirewallPublicIpModule '../../../modules/network/public-ip.bicep' = {
  name: 'deployFirewallPublicIp'
  params: {
    pipName: FirewallPublicIpName
    location: location
    sku: FirewallPublicIpSku
  }
}

module AppGatewayPublicIpModule '../../../modules/network/public-ip.bicep' = {
  name: 'deployAppGatewayPublicIp'
  params: {
    pipName: AppGatewayPublicIpName
    location: location
    sku: AppGatewayPublicIpSku
  }
}
