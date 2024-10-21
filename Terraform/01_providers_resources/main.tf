resource "azurerm_resource_group" "rg1" {
  name     = "NextOpsRG21"
  location = "South India"
}


#new code related to vnet
resource "azurerm_virtual_network" "vnet1" {
  name                = "NextOpsVNET21"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]

 subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
  }

  tags = {
    environment = "Production"
  }

}