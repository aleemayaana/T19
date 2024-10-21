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

resource "azurerm_subnet" "subnet" {
    count                   = length(var.subnet_name)  #4
    name                    = var.subnet_name[count.index] #var.subnet_name[0]=subnet1, var.subnet_name[1]=subnet2, var.subnet_name[2]=subnet3, var.subnet_name[3]=subnet4
    virtual_network_name    = azurerm_virtual_network.vnet1.name 
    resource_group_name     = azurerm_resource_group.rg1.name
    address_prefixes        = [ "10.10.${count.index}.0/24" ] #10.10.0.0/24, 10.10.1.0/24, 10.10.2.0/24, 10.10.3.0/24
}

resource "azurerm_public_ip" "pubip"{
    count               = length(var.pip)
    name                = var.pip[count.index]
    resource_group_name = azurerm_resource_group.rg1.name
    location            = azurerm_resource_group.rg1.location
    allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic"{
    count               = 4                     #[0,1,2,3]
    name                = "nic-${count.index}"  #nic-0, nic-1, nic-2, nic-3
    location            = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.subnet[count.index].id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.pubip[count.index].id 
    }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = length(var.vm_name)
  name                = var.vm_name[count.index]
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "Secure*123456"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
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