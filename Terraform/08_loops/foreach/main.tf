resource "azurerm_resource_group" "rg"{
    for_each    = var.resourcedetails

    name        = each.value.rg_name
    location    = each.value.rg_location
}

resource "azurerm_virtual_network" "vnet" {
    for_each            = var.resourcedetails

    name                = each.value.vnet_name
    resource_group_name = azurerm_resource_group.rg[each.key].name
    location            = azurerm_resource_group.rg[each.key].location 
    address_space       = each.value.address_space
}

resource "azurerm_subnet" "subnet"{
    for_each = var.resourcedetails

    name                    = each.value.subnet_name
    virtual_network_name    = azurerm_virtual_network.vnet[each.key].name  
    resource_group_name     = azurerm_resource_group.rg[each.key].name 
    address_prefixes        = each.value.address_prefix 
}

resource "azurerm_network_interface" "nic" {
    for_each = var.resourcedetails

    name                = each.value.nic_name
    location            = azurerm_resource_group.rg[each.key].location 
    resource_group_name = azurerm_resource_group.rg[each.key].name
    ip_configuration {
      name      =   "ipconfig"
      subnet_id = azurerm_subnet.subnet[each.key].id 
      private_ip_address_allocation = "Dynamic"
    }  
}

resource "azurerm_virtual_machine" "vm" {
  for_each = var.resourcedetails

  name                  = each.value.vm_name
  location              = azurerm_resource_group.rg[each.key].location
  resource_group_name   = azurerm_resource_group.rg[each.key].name
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  vm_size               = each.value.size

  storage_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = "latest"
  }

  storage_os_disk {
    name              = "${each.value.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = each.value.vm_name
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}