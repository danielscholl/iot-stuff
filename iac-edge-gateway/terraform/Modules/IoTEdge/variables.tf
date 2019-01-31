##############################################################
# This module allows the creation of an IoT Edge
##############################################################

variable "ResourceGroup" {
  type    = "string"
  default = "DefaultGroup"
}

variable "Unique" {
  type = "string"
}

variable "Location" {
  type    = "string"
  default = "EastUs"
}

variable "Environment" {
  type    = "string"
  default = "PoC"
}

variable "VNetId" {
  type = "string"
}

variable "VmName" {
  type    = "string"
  default = "vm-ip"
}

variable "VmSize" {
  description = "The VM_SKU to use for the agents in the cluster"
  default     = "Standard_DS1_v2"
}

variable "UserName" {
  type    = "string"
  default = "terraform"
}

variable "PublicKey" {
  type = "string"
}

variable "CloudInitPath" {
  type = "string"
}
