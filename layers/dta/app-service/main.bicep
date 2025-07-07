targetScope = 'resourceGroup'

param appService object

module appServicePlanModule '../../../modules/app-service/appServicePlan.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    name: appService.appServicePlanName
    location: appService.location
    skuName: appService.skuName
    skuTier: appService.skuTier
    capacity: appService.capacity
  }
}

module webAppModule '../../../modules/app-service/windowsWebApp.bicep' = {
  name: 'windowsWebAppDeployment'
  dependsOn: [
    appServicePlanModule
  ]
  params: {
    webAppName: appService.webAppName
    location: appService.location
    appServicePlanId: appServicePlanModule.outputs.appServicePlanId
  }
}
