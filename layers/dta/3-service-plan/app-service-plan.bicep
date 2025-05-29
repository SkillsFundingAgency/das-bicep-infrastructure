@description('App config JSON as object')
param config object

@description('Remote state output from core layer')
param coreRg object

var servicePlans = config.webApp.inflate ? [for plan in config.webApp.servicePlans: plan] : []

module servicePlansMod 'root_modules/az-appservices/main.bice' = [for plan in servicePlans: {
  name: 'asp-${plan.name}'
  params: {
    name: plan.name
    location: coreRg.location
    resourceGroupName: coreRg.name
    osType: plan.os_type
    skuName: plan.sku_name
    workerCount: plan.sku_name != 'EP2' ? plan.worker_count : 1
  }
}]
