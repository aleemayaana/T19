resource "azurerm_resource_group" "rg"{
    name     = var.rg_name
    location = var.rg_location
}

resource "azurerm_virtual_network" "vnet1" {
    name                = var.env_prod == "no" ? "dev-vnet" : "prod-vnet"
    resource_group_name = azurerm_resource_group.rg.name 
    location            = azurerm_resource_group.rg.location
    address_space       = var.env_prod == "no" ? ["10.90.0.0/16"] : [ "10.80.0.0/16" ]   
}