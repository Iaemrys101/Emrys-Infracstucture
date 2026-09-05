variable "aks_admin_object_id" {
  description = "Object ID of the human administrator for AKS"
  type        = string
}

resource "azurerm_role_assignment" "aks_human_admin" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = var.aks_admin_object_id
}

resource "azurerm_role_assignment" "github_aks_user" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = "3cc39f8b-ae8c-4720-86ad-f4c84ea375ee"
}

resource "azurerm_role_assignment" "github_aks_writer" {
  scope                = "${azurerm_kubernetes_cluster.aks.id}/namespaces/default"
  role_definition_name = "Azure Kubernetes Service RBAC Writer"
  principal_id         = "3cc39f8b-ae8c-4720-86ad-f4c84ea375ee"
}