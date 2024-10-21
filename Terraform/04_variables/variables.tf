variable "rg_name" {
    type = string
    description = "Resource Group Name"  
}

variable "rg_location" {
    type = string  
}

variable "vnet_name" {
    type = string  
}

variable "vnet_address_space" {
    type = list(string) 
}

variable "subnet1_name" {
    type = string  
}

variable "subnet1_addr_prefix" {
    type = list(string)  
}