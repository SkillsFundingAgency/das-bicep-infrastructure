targetScope = 'resourceGroup'

param monitoring object

module logAnalyticsModule '../../../modules/monitoring/log-analytics.bicep' = {
  name: 'deployLogAnalytics'
  params: {
    name: monitoring.logAnalytics.name
    location: monitoring.location
    skuName: monitoring.logAnalytics.sku
    retentionInDays: monitoring.logAnalytics.retentionInDays
  }
}

module appInsightsModule '../../../modules/monitoring/app-insights.bicep' = {
  name: 'deployAppInsights'
  params: {
    name: monitoring.appInsights.name
    location: monitoring.location
    applicationType: 'web'
    workspaceResourceId: logAnalyticsModule.outputs.resourceId
  }
  dependsOn: [
    logAnalyticsModule
  ]
}
