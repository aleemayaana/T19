variable "rg_name" {
  type        = string
  description = "Resource Group Name"
  default     = "NextOpsLinuxRG"
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

variable "subnet1_name" {
  type = string
}

variable "subnet1_addr_prefix" {
  type = list(string)
}

variable "nic_name" {
  type = string
}

variable "vm_name" {
  type = string

}
