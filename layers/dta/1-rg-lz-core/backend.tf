# # This file needs to be updated with correct value at part of pipeline execution.
# locals {
#   config_data  = jsondecode(file("../../../region/uksouth/config.json"))
# }
#  terraform {
#    backend "azurerm" {
#       key                  = "resource-groups-core.tfstate"
#       resource_group_name = local.config_data.remote-state-config.resource_group_name
#       storage_account_name = local.config_data.remote-state-config.storage_account_name
#       container_name = local.config_data.remote-state-config.container_name
#    }
#  }

