##############################################################
# This module allows the creation of a Container Registry
##############################################################

variable "ResourceGroup" {
  type    = "string"
  default = "DefaultGroup"
}

variable "Location" {
  type    = "string"
  default = "EastUs"
}

variable "RegistryName" {
  type    = "string"
  default = "moduleacr"
}

variable "Environment" {
  type    = "string"
  default = "poc"
}

variable "ClientId" {
  type = "string"
}
