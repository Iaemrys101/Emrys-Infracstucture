resource "azurerm_resource_group" "emrys" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "emrys" {
  name                = var.vnet_name
  location            = azurerm_resource_group.emrys.location
  resource_group_name = azurerm_resource_group.emrys.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "workload" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.emrys.name
  virtual_network_name = azurerm_virtual_network.emrys.name
  address_prefixes     = var.subnet_address_prefixes
}