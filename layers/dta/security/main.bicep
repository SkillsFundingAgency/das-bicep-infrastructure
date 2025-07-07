targetScope = 'resourceGroup'

param security object

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' existing = {
  name: security.vnetName
}

resource FirewallSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' existing = {
  parent: vnet
  name: security.FirewallSubnetName
}

resource FirewallPublicIp 'Microsoft.Network/publicIPAddresses@2024-07-01' existing = {
  name: security.FirewallPublicIpName
}

module firewallModule '../../../modules/security/azureFirewall.bicep' = {
  name: 'azureFirewallDeployment'
  params: {
    firewallName: security.firewallName
    location: security.location
    skuTier: security.FirewallSkuTier
    skuName: security.FirewallSkuName
    subnetId: FirewallSubnet.id
    publicIpId: FirewallPublicIp.id
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' existing = {
  parent: vnet
  name: security.AppGwSubnetName
}

resource AppGwPublicIp 'Microsoft.Network/publicIPAddresses@2024-07-01' existing = {
  name: security.AppGwPublicIpName
}

module appGateway '../../../modules/security/appGatewayWaf.bicep' = {
  name: 'deployAppGateway'
  params: {
    appGwName: security.AppGwName
    location: security.location
    skuName: security.AppGwSkuName
    skuTier: security.AppGwSkuTier
    subnetId: subnet.id
    publicIpId: AppGwPublicIp.id
    wafEnabled: security.wafEnabled
    wafMode: security.wafMode
    minCapacity: security.AppGwMinCapacity
    maxCapacity: security.AppGwMaxCapacity
  }
}
