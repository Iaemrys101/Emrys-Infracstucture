resource "azurerm_role_assignment" "storage_blob_reader" {
  scope                = azurerm_storage_account.emrys.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_linux_virtual_machine.vm["reader"].identity[0].principal_id
  principal_type       = "ServicePrincipal"

  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "storage_blob_contributor" {
  scope                = azurerm_storage_account.emrys.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_virtual_machine.vm["contributor"].identity[0].principal_id
  principal_type       = "ServicePrincipal"

  skip_service_principal_aad_check = true
}