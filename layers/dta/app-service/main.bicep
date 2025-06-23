targetScope = 'resourceGroup'

param location string
param appServicePlanName string
param skuName string
param skuTier string
param capacity int
param webAppName string

module appServicePlanModule '../../../modules/app-service/appServicePlan.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    name: appServicePlanName
    location: location
    skuName: skuName
    skuTier: skuTier
    capacity: capacity
  }
}

module webAppModule '../../../modules/app-service/windowsWebApp.bicep' = {
  name: 'windowsWebAppDeployment'
  dependsOn: [
    appServicePlanModule
  ]
  params: {
    webAppName: webAppName
    location: location
    appServicePlanId: appServicePlanModule.outputs.appServicePlanId
  }
}
