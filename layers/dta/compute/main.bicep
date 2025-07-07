targetScope = 'resourceGroup'

param compute object

module appServicePlanModule '../../../modules/app-service/appServicePlan.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    name: compute.appServicePlanName
    location: compute.location
    skuName: compute.skuName
    skuTier: compute.skuTier
    capacity: compute.capacity
  }
}

module webAppModule '../../../modules/app-service/windowsWebApp.bicep' = {
  name: 'windowsWebAppDeployment'
  dependsOn: [
    appServicePlanModule
  ]
  params: {
    webAppName: compute.webAppName
    location: compute.location
    appServicePlanId: appServicePlanModule.outputs.appServicePlanId
  }
}

resource vmNic 'Microsoft.Network/networkInterfaces@2024-07-01' existing = {
  name: compute.VmNicName
}

module vmModule '../../../modules/windows-vm/windows-vm.bicep' = {
  name: 'deployWindowsVM'
  params: {
    vmName: compute.vmName
    location: compute.location
    nicId: vmNic.id
    adminUsername: compute.vmAdminUsername
    adminPassword: compute.vmAdminPassword
    vmSize: compute.vmSize
    imagePublisher: compute.vmImage.publisher
    imageOffer: compute.vmImage.offer
    imageSku: compute.vmImage.sku
    imageVersion: compute.vmImage.version
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' existing = {
  name: compute.vnetName
}

resource vmssSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' existing = {
  parent: vnet
  name: compute.vmssSubnetName
}

module vmssModule '../../../modules/vmss/vmss.bicep' = {
  name: 'deployVmss'
  params: {
    vmssName: compute.vmssName
    location: compute.location
    subnetId: vmssSubnet.id
    adminUsername: compute.vmssAdminUsername
    adminPassword: compute.vmssAdminPassword
    vmSize: compute.vmssVmSize
    instanceCount: compute.vmssInstanceCount
    imagePublisher: compute.vmssImage.publisher
    imageOffer: compute.vmssImage.offer
    imageSku: compute.vmssImage.sku
    imageVersion: compute.vmssImage.version
  }
}
