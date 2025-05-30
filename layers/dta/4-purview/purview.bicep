param config object
param coreRg object
param appTeamRg object

var inflate = config.purview.inflate

module purview 'modules/governance/purview.bicep' = if (inflate) {
  name: 'purview-account-deploy'
  params: {
    name: config.purview.name
    location: coreRg.location
    resourceGroupName: coreRg.name
    managedResourceGroupName: config.purview.managedResourceGroupName
    skuName: config.purview.skuName
    tags: config.tags
  }
}
