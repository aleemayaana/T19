resourcedetails = {
  "eastus" = { #0
    rg_name         = "east-rg"    #each.value.rg_name
    rg_location     = "eastus"     #each.value.rg_location  
    vnet_name       = "east-vnet"
    address_space   = ["10.10.0.0/16"]
    subnet_name     = "esubnet1"
    address_prefix  = ["10.10.0.0/24"]
    vm_name         = "eastvm1"
    size            = "Standard_B1s"
    nic_name        = "enic1"
    publisher       = "Canonical"
    offer           = "0001-com-ubuntu-server-jammy"
    sku             = "22_04-lts"    
  }
  "westus" = { #1
    rg_name         = "west-rg"
    rg_location     = "westus"
    vnet_name       = "west-vnet"
    address_space   = ["10.20.0.0/16"]
    subnet_name     = "wsubnet1"
    address_prefix  = ["10.20.0.0/24"]
    vm_name         = "westvm1"
    size            = "Standard_B2s"
    nic_name        = "wnic1"
    publisher       = "Microsoft"
    offer           = "WindowsServer"
    sku             = "2022"    
  }
}