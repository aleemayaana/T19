# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.4.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "NextOps"
    storage_account_name = "nextopstfsa19"
    container_name = "tfstate"
    key = "DEV/dev.tfstate"
    access_key = "GOULKG/0MnQFx8LXmUvyAKn05X2PrsT7L/btMKpFOm8kRqrKsTf6gTJZ1+Vd5CZmFxjVwPi9xbq4+AStTd1z8g=="
  }
}

provider "azurerm" {
    features {}      
    subscription_id = "a355c32e-4a22-4b05-aab4-be236850fa6e"  
}

module "dev" {
    source              = "../../vnet_module"
    rg_name             = "DevRG"
    rg_location         = "EastUS"
    vnet_name           = "DevVNET"
    vnet_addr_space     = [ "10.10.0.0/16" ]
    subnet1_name        = "devsubnet01"
    subnet1_addr_prefix = [ "10.10.0.0/24" ]
    vm_name             = "DevLVM01"
    vm_size             = "Standard_B1s"
    nic_name            = "devnic1"  
}