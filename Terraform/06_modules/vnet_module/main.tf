resource "azurerm_resource_group" "rg1"{
    name        = var.rg_name
    location    = var.rg_location
}

resource "azurerm_virtual_network" "vnet1" {
    name                = var.vnet_name
    resource_group_name = azurerm_resource_group.rg1.name
    location            = azurerm_resource_group.rg1.location
    address_space       = var.vnet_addr_space
}

resource "azurerm_subnet" "subnet1" {
    name                    = var.subnet1_name
    virtual_network_name    = azurerm_virtual_network.vnet1.name
    resource_group_name     = azurerm_resource_group.rg1.name 
    address_prefixes        = var.subnet1_addr_prefix 
}

resource "azurerm_network_interface" "vmnic1" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                            = var.vm_name
  resource_group_name             = azurerm_resource_group.rg1.name
  location                        = azurerm_resource_group.rg1.location
  size                            = var.vm_size
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