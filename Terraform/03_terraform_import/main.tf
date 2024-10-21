resource "azurerm_resource_group" "tfrg" {
   name = "TerraformRG"
   location = "EastUS"
}

resource "azurerm_virtual_network" "tfvnet" {
   name = "TFVNET19"
   location = azurerm_resource_group.tfrg.location
   address_space = [ "10.1.0.0/16" ]
   resource_group_name = azurerm_resource_group.tfrg.name
}

resource "azurerm_subnet" "subnet1" {
    name = "Subnet01"
    virtual_network_name = azurerm_virtual_network.tfvnet.name
    resource_group_name = azurerm_resource_group.tfrg.name 
    address_prefixes = [ "10.1.0.0/24" ]
}