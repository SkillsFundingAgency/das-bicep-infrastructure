targetScope = 'resourceGroup'

param location string
param firewallName string
param FirewallSkuTier string
param FirewallSkuName string
param vnetName string
param FirewallSubnetName string
param FirewallPublicIpName string

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' existing = {
  name: vnetName
}

resource FirewallSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' existing = {
  parent: vnet
  name: FirewallSubnetName
}

resource FirewallPublicIp 'Microsoft.Network/publicIPAddresses@2024-07-01' existing = {
  name: FirewallPublicIpName
}

module firewallModule '../../../modules/security/azureFirewall.bicep' = {
  name: 'azureFirewallDeployment'
  params: {
    firewallName: firewallName
    location: location
    skuTier: FirewallSkuTier
    skuName: FirewallSkuName
    subnetId: FirewallSubnet.id
    publicIpId: FirewallPublicIp.id
  }
}

param AppGwName string
param AppGwSkuName string
param AppGwSkuTier string
param AppGwSubnetName string
param AppGwPublicIpName string
param wafEnabled bool
param wafMode string
param AppGwMinCapacity int
param AppGwMaxCapacity int


resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' existing = {
  parent: vnet
  name: AppGwSubnetName
}

resource AppGwPublicIp 'Microsoft.Network/publicIPAddresses@2024-07-01' existing = {
  name: AppGwPublicIpName
}

module appGateway '../../../modules/security/appGatewayWaf.bicep' = {
  name: 'deployAppGateway'
  params: {
    appGwName: AppGwName
    location: location
    skuName: AppGwSkuName
    skuTier: AppGwSkuTier
    subnetId: subnet.id
    publicIpId: AppGwPublicIp.id
    wafEnabled: wafEnabled
    wafMode: wafMode
    minCapacity: AppGwMinCapacity
    maxCapacity: AppGwMaxCapacity
  }
}
