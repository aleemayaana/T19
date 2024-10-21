resource "azurerm_resource_group" "testrg" {
  name     = var.rg_name
  location = var.rg_location
}

locals {
  rg_name     = azurerm_resource_group.testrg.name
  rg_location = azurerm_resource_group.testrg.location
  vnet_name   = azurerm_virtual_network.linuxvnet.name
  vm_szie     = "Standard_B1s"
  #prefix = "NextOps"
}

resource "azurerm_virtual_network" "linuxvnet" {
  name                = var.vnet_name
  address_space       = var.vnet_addr_space
  location            = local.rg_location
  resource_group_name = local.rg_name
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1_name
  resource_group_name  = local.rg_name
  virtual_network_name = local.vnet_name
  address_prefixes     = var.subnet1_addr_prefix
}

resource "azurerm_network_interface" "vmnic1" {
  name                = var.nic_name
  location            = local.rg_location
  resource_group_name = local.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                            = var.vm_name
  resource_group_name             = local.rg_name
  location                        = local.rg_location
  size                            = local.vm_szie
  disable_password_authentication = false
  admin_username                  = "adminuser"
  admin_password                  = "Secure*12345678"
  network_interface_ids = [
    azurerm_network_interface.vmnic1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}