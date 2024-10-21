variable "rg_name" {
   type = string
}

variable "rg_location" {
   type = string
}

variable "vnet_name" {
    type = string  
}

variable "vnet_addr_space" {
    type = list(string)  
}

variable "subnet_name" {
    type = list(string)
}

variable "pip" {
    type = list(string)  
}

variable "vm_name" {
    type = list(string)
  
}