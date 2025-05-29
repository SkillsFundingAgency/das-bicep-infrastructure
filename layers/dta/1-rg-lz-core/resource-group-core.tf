// Global Platform Resource Group is handled as part of the inflation pipeline so is not included here

locals {
  config_data  = jsondecode(file("../config.json"))
}

 module "platform-rg" {
     source = "../../../modules/az-resourcegroups"
     count  = local.config_data.rg-lz-core.inflate ? 1 : 0
     resource-group-name   = local.config_data.rg-lz-core.hub_rg
     region = local.config_data.common.region
     tags = local.config_data.common.tags
}
 module "app-team-rg" {
     source = "../../../modules/az-resourcegroups"
     count  = local.config_data.rg-lz-core.inflate ? 1 : 0
     resource-group-name   = local.config_data.rg-lz-core.spoke_rg
     region = local.config_data.common.region
     tags = local.config_data.common.tags
 }