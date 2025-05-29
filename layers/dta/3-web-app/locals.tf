locals {

  ########################################################################
  #                       APP SERVICE PLAN
  ########################################################################
  service_plans = [
    {
      name                         = "app-plan-dev-portals"
      os_type                      = "Windows"
      sku_name                     = "P1v2"
      # maximum_elastic_worker_count = 20
    },
  ]

  ########################################################################
  #                       WINDOWS WEB APP
  ########################################################################
  windows_web_apps = [
    {
      name                       = "dev-logic-admin-portal"
      service_plan_id            = module.Service_Plan["app-plan-dev-portals"].id
      client_affinity_enabled    = true
      client_certificate_enabled = false
      client_certificate_mode    = "Required"
      https_only                 = true
      always_on                  = true
      worker_count               = 1
      http2_enabled              = false
      app_settings               = {
        # appsetting1 = ""
        appsetting1 = "@Microsoft.KeyVault(SecretUri=https://devkeys-uksouth-dev.vault.azure.net/secrets/appkey/558863b6ead04fe281352c928334560a)"
        # appsetting1 = data.azurerm_key_vault_secret.key_vault_secret.value
        

      }
      connection_string = [
        {
          name  = "testkey"
          value = data.azurerm_key_vault_secret.key_vault_secret.value
          type  = "SQLServer"
        }
      ]
      identity_type = "SystemAssigned"
    }
  ]

}