// subnet.bicep
param name string
param vnetName string
param addressPrefixes array


resource vnet 'Microsoft.Network/virtualNetworks@2023-02-01' existing = {
  name: vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-02-01' = {
  name: name
  parent: vnet
  properties: {
    addressPrefixes: addressPrefixes
  }
}
