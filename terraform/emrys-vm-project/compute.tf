locals {
  vm_instances = {
    reader = {
      name     = "vm-emrys-dev-uks-001"
      nic_name = "nic-emrys-dev-uks-001"
    }

    contributor = {
      name     = "vm-emrys-dev-uks-002"
      nic_name = "nic-emrys-dev-uks-002"
    }
  }
}

resource "azurerm_network_security_group" "workload" {
  name                = "nsg-workload-emrys-dev-uks-001"
  location            = azurerm_resource_group.emrys.location
  resource_group_name = azurerm_resource_group.emrys.name

  security_rule {
    name                       = "AllowSSHFromVNet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowStorageHTTPS"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = var.private_endpoint_subnet_address_prefixes[0]
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "workload" {
  subnet_id                 = azurerm_subnet.workload.id
  network_security_group_id = azurerm_network_security_group.workload.id
}

resource "azurerm_network_interface" "vm" {
  for_each = local.vm_instances

  name                = each.value.nic_name
  location            = azurerm_resource_group.emrys.location
  resource_group_name = azurerm_resource_group.emrys.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.workload.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = local.vm_instances

  name                = each.value.name
  computer_name       = each.value.name
  location            = azurerm_resource_group.emrys.location
  resource_group_name = azurerm_resource_group.emrys.name
  size                = var.vm_size
  admin_username      = var.admin_username

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.vm[each.key].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(pathexpand(var.ssh_public_key_path))
  }

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    name                 = "osdisk-${each.value.name}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  boot_diagnostics {}

  tags = merge(var.tags, {
    access_role = each.key
  })
}