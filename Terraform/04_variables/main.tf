resource "azurerm_resource_group" "newrg" {
    name     = var.rg_name
    location = var.rg_location
}

resource "azurerm_virtual_network" "newvnet"{
    name                = var.vnet_name
    resource_group_name = azurerm_resource_group.newrg.name
    location            = azurerm_resource_group.newrg.location
    address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "subnet01" {
    name                    = var.subnet1_name
    virtual_network_name    = azurerm_virtual_network.newvnet.name 
    resource_group_name     = azurerm_resource_group.newrg.name 
    address_prefixes        = var.subnet1_addr_prefix
}