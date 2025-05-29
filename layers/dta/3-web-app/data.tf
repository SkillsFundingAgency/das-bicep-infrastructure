data "azurerm_key_vault" "key_vault" {
  name                = "devkeys-uksouth-dev"
  resource_group_name = "uksouth-terraform-sharedservices"
}

data "azurerm_key_vault_secret" "key_vault_secret" {
  name = "testkey" #this is where you put the name of the secret
    # key_vault_id = "your_key_id_hardcoded_here"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}