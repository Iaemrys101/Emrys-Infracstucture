output "resource_group_name" {
  description = "Name of the Emrys resource group."
  value       = azurerm_resource_group.emrys.name
}

output "vnet_name" {
  description = "Name of the Emrys virtual network."
  value       = azurerm_virtual_network.emrys.name
}

output "subnet_name" {
  description = "Name of the workload subnet."
  value       = azurerm_subnet.workload.name
}

output "subnet_id" {
  description = "Resource ID used when connecting VM network interfaces."
  value       = azurerm_subnet.workload.id
}

output "storage_account_name" {
  value = azurerm_storage_account.emrys.name
}

output "storage_blob_endpoint" {
  value = azurerm_storage_account.emrys.primary_blob_endpoint
}

output "storage_private_endpoint_ip" {
  value = azurerm_private_endpoint.storage_blob.private_service_connection[0].private_ip_address
}