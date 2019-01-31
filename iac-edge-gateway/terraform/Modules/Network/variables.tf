variable "ResourceGroup" {
  type    = "string"
  default = "DefaultGroup"
}

variable "Location" {
  type    = "string"
  default = "EastUs"
}

variable "VNetName" {
  type    = "string"
  default = "module-vnet"
}

variable "AddressSpace" {
  type    = "list"
  default = ["10.0.0.0/16"]
}

variable "Subnet1Name" {
  type    = "string"
  default = "subnet1"
}

variable "Subnet1Prefix" {
  type    = "string"
  default = "10.0.0.0/20"
}

variable "Nsg1Name" {
  type    = "string"
  default = "module-nsg2"
}

variable "Environment" {
  type    = "string"
  default = "poc"
}
