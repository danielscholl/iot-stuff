##############################################################
# This module allows the creation of an IoT Hub
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
