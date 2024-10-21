resource "azurerm_resource_group" "tfrg" {
  name     = "DevRG"
  location = "East US"
}

resource "azurerm_virtual_network" "tfvnet" {
  name                = "TFVNET02"
  address_space       = ["10.1.0.0/16"] #65536 Ip Addresses
  location            = azurerm_resource_group.tfrg.location
  resource_group_name = azurerm_resource_group.tfrg.name
}

resource "azurerm_subnet" "tfsubnet1" {
  name                 = "Subnet01"
  resource_group_name  = azurerm_resource_group.tfrg.name
  virtual_network_name = azurerm_virtual_network.tfvnet.name
  address_prefixes     = ["10.1.0.0/24"] #254 Ip Addresses
}

resource "azurerm_subnet" "tfsubnet2" {
  name                 = "Subnet02"
  resource_group_name  = azurerm_resource_group.tfrg.name
  virtual_network_name = azurerm_virtual_network.tfvnet.name
  address_prefixes     = ["10.1.1.0/24"] #254 Ip Addresses
}
