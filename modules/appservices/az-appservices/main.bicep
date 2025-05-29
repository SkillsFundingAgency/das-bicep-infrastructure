param name string
param location string
param resourceGroupName string
param osType string = 'Windows'
param skuName string = 'P1v2'
param workerCount int = 1

resource servicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: name
  location: location
  sku: {
    name: skuName
    tier: skuName
  }
  kind: osType
  properties: {
    workerSize: 0
    numberOfWorkers: skuName != 'EP2' ? workerCount : null
  }
}
