# Copyright (c) HashiCorp, Inc.
variable "name" {
  type        = string
  description = "Name of App Service"
}

# variable "prefix" {
#   type        = string
#   description = "The prefix used for all resources in this example"
# }

variable "location" {
  type        = string
  description = "The Azure location where all resources in this example should be created"
}


# variable "location_short" {
#   description = "Short string for Azure location."
#   type        = string
# }

# variable "client_name" {
#   description = "Client name/account used in naming"
#   type        = string
# }

# variable "environment" {
#   description = "Project environment"
#   type        = string
# }

# variable "stack" {
#   description = "Project stack name"
#   type        = string
# }

variable "resource-group-name" {
  description = "Resource group name"
  type        = string
}

variable "os-type" {
  description = "The O/S type for the App Services to be hosted in this plan. Possible values include `Windows`, `Linux`, and `WindowsContainer`."
  type        = string

  # validation {
  #   condition     = try(contains(["Windows", "Linux", "WindowsContainer"], var.os_type), true)
  #   error_message = "The `os_type` value must be valid. Possible values are `Windows`, `Linux`, and `WindowsContainer`."
  # }
}

variable "sku-name" {
  description = "The SKU for the plan. Possible values include B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, Y1, EP1, EP2, EP3, WS1, WS2, and WS3."
  type        = string

  # validation {
  #   condition     = try(contains(["B1", "B2", "B3", "D1", "F1", "FREE", "I1", "I2", "I3", "I1v2", "I2v2", "I3v2", "P1v2", "P2v2", "P3v2", "P0v3", "P1v3", "P2v3", "P3v3", "S1", "S2", "S3", "SHARED", "Y1", "EP1", "EP2", "EP3", "WS1", "WS2", "WS3"], var.sku_name), true)
  #   error_message = "The `sku_name` value must be valid. Possible values include B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, Y1, EP1, EP2, EP3, WS1, WS2, and WS3."
  # }
}

# variable "app-service-environment-id" {
#   description = "The ID of the App Service Environment to create this Service Plan in. Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm_app_service_environment, or I1v2, I2v2, I3v2 for azurerm_app_service_environment_v3"
#   type        = string
#   # default     = null
# }

variable "worker-count" {
  description = "The number of Workers (instances) to be allocated."
  # type        = number
  # default     = 3
}

variable "maximum-elastic-worker-count" {
  description = "The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU."
  type        = number
  default     = null
}

variable "per-site-scaling-enabled" {
  description = "Should Per Site Scaling be enabled."
  # type        = bool
  # default     = false
}

variable "zone-balancing-enabled" {
  description = "Should the Service Plan balance across Availability Zones in the region."
  # type        = bool
  # default     = true
}

variable "tags" {
  type        = map
  description = "Tags for the workspace resource"
}

variable "app-settings" {
  description = "A key-value pair of App Settings."
  type        = map(string)
  default     = {}
}

