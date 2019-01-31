##############################################################
# This module allows the creation of a Resource Group
##############################################################

variable "ResourceGroup" {
  type    = "string"
  default = "DefaultGroup"
}

variable "Location" {
  type    = "string"
  default = "EastUs"
}

variable "Environment" {
  type    = "string"
  default = "PoC"
}
