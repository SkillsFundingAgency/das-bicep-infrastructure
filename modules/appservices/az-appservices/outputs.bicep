# output "service_plan_id" {
#   description = "Id of the created App Service Plan"
#   value       = azurerm_service_plan.plan.id
# }

# output "service_plan_is_reserved" {
#   description = "If the instance is reserved"
#   value       = azurerm_service_plan.plan.reserved
# }

# output "service_plan_kind" {
#   description = "The kind of the plan"
#   value       = azurerm_service_plan.plan.kind
# }

# output "service_plan_location" {
#   description = "Azure location of the created App Service Plan"
#   value       = azurerm_service_plan.plan.location
# }

# output "service_plan_name" {
#   description = "Name of the created App Service Plan"
#   value       = azurerm_service_plan.plan.name
# }

output "app_service_plan_id" {
  description = "The resource ID of the App Service Plan component"
  value       = azurerm_service_plan.main.id
}
