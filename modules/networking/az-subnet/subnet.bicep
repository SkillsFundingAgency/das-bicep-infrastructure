param name string
param resourceGroupName string
param vnetName string
param addressPrefixes array

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-02-01' = {
  name: name
  parent: resourceId('Microsoft.Network/virtualNetworks', vnetName)
  properties: {
    addressPrefix: null
    addressPrefixes: addressPrefixes
  }
}
