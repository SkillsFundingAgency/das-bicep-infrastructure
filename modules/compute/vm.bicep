param adminUsername string
param adminPassword string
param vmName string
param vmSize string
param imageName string
param imagePublisher string
param imageOffer string
param imageSku string
param imageVersion string
param location string = resourceGroup().location
param subnetId string

resource vm 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: imageSku
        version: imageVersion
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        name: '${vmName}_OsDisk'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.outputs.id
          properties: {
            primary: true
          }
        }
      ]
    }
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-11-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroup.outputs.id
    }
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-11-01' existing = {
  name: 'default-nsg'
  scope: resourceGroup()
}

output vmId string = vm.id
output vmName string = vm.name
output vmPrivateIp string = networkInterface.properties.ipConfigurations[0].properties.privateIPAddress
output networkInterfaceId string = networkInterface.id
