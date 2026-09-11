resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "you_kv_secrets_officer" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Preserve the existing GitHub deployment identity's AKS access.
resource "azurerm_role_assignment" "github_aks_user" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = "3cc39f8b-ae8c-4720-86ad-f4c84ea375ee"
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "github_aks_writer" {
  scope                = "${azurerm_kubernetes_cluster.aks.id}/namespaces/default"
  role_definition_name = "Azure Kubernetes Service RBAC Writer"
  principal_id         = "3cc39f8b-ae8c-4720-86ad-f4c84ea375ee"
  principal_type       = "ServicePrincipal"
}
