resource "random_string" "storage_suffix" {
  length  = 6
  upper   = false
  special = false
  numeric = true
}

resource "azurerm_storage_account" "emrys" {
  name                     = "${var.storage_account_prefix}${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.emrys.name
  location                 = azurerm_resource_group.emrys.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  default_to_oauth_authentication = true
  shared_access_key_enabled       = false
  local_user_enabled              = false
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false

  tags = var.tags
}

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.emrys.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                 = "link-emrys-dev-blob"
  private_dns_zone_id  = azurerm_private_dns_zone.blob.id
  virtual_network_id   = azurerm_virtual_network.emrys.id
  registration_enabled = false

  tags = var.tags
}

resource "azurerm_private_endpoint" "storage_blob" {
  name                = "pep-storage-emrys-dev-uks-001"
  location            = azurerm_resource_group.emrys.location
  resource_group_name = azurerm_resource_group.emrys.name
  subnet_id           = azurerm_subnet.private_endpoints.id

  private_service_connection {
    name                           = "psc-storage-emrys-dev-uks-001"
    private_connection_resource_id = azurerm_storage_account.emrys.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdzg-storage-blob"
    private_dns_zone_ids = [azurerm_private_dns_zone.blob.id]
  }

  tags = var.tags
}