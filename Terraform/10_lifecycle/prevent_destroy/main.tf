terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.4.0"
    }
  }
}

provider "azurerm" {
    features {}      
    subscription_id = "a355c32e-4a22-4b05-aab4-be236850fa6e"  
}

resource "azurerm_resource_group" "rgname" {
  name     = "nextopsrg07"
  location = "EastUS"
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_virtual_network" "nextopsvnet04" {
  name                  = "NextOpsVNET07"
  resource_group_name   = azurerm_resource_group.rgname.name
  location              = azurerm_resource_group.rgname.location
  address_space         = ["10.4.0.0/16"]  
  lifecycle {
    prevent_destroy = false
  }
}

