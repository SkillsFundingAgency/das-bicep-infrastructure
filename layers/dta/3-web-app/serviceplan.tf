locals {
  config_data = jsondecode(file("../config.json"))
}

data "azurerm_subscription" "current" {}

data "terraform_remote_state" "resource-group-layer" {
  backend = "azurerm"
  config = {
    resource_group_name  = local.config_data.common.remote-state-config.resource_group_name
    storage_account_name = local.config_data.common.remote-state-config.storage_account_name
    container_name       = local.config_data.common.remote-state-config.container_name
    key                  = "D:a1sregionuksouth1-rg-lz-corebackend.tf.tfstate"
  }
}

module "Service_Plan" {
  source = "../../../modules/az-service-plan"

  for_each = local.config_data.web-app.inflate ? { for service_plan in local.service_plans : service_plan.name => service_plan } : {}

  location                   = data.terraform_remote_state.resource-group-layer.outputs.app-team-rg[0].resource_group.location
  resource_group_name        = data.terraform_remote_state.resource-group-layer.outputs.app-team-rg[0].resource_group.name

  name                         = each.value.name
  os_type                      = lookup(each.value, "os_type", "Windows")
  sku_name                     = lookup(each.value, "sku_name", "P2v2")
  # maximum_elastic_worker_count = lookup(each.value, "maximum_elastic_worker_count", 1)
  worker_count                 = lookup(each.value, "worker_count", 1)

  # depends_on = [module.Resource_Group]
}

module "Windows_Web_App" {
  source = "../../../modules/az-windows-webapp"

  for_each =  local.config_data.web-app.inflate ? { for windows_web_app in local.windows_web_apps : windows_web_app.name => windows_web_app } : {}

  location                   = data.terraform_remote_state.resource-group-layer.outputs.app-team-rg[0].resource_group.location
  resource_group_name        = data.terraform_remote_state.resource-group-layer.outputs.app-team-rg[0].resource_group.name

  name                       = each.value.name
  service_plan_id            = each.value.service_plan_id
  client_affinity_enabled    = each.value.client_affinity_enabled
  client_certificate_enabled = each.value.client_certificate_enabled
  client_certificate_mode    = each.value.client_certificate_mode
  tags                       = local.config_data.common.tags
  https_only                 = each.value.https_only
  always_on                  = each.value.always_on
  worker_count               = each.value.worker_count
  http2_enabled              = each.value.http2_enabled
  app_settings               = each.value.app_settings
  connection_string          = each.value.connection_string
  identity_type              = each.value.identity_type

  depends_on = [module.Service_Plan]
}