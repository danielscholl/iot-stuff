/*
.Synopsis
   Terraform Variables
.DESCRIPTION
   This file holds the variables for Terraform AKS Module.
*/

#########################################################
# VARIABLES
#########################################################

variable "Environment" {
  type        = "string"
  description = "Resource Environment Tag"
  default     = "PoC"
}

variable "Location" {
  type        = "string"
  description = "Location for the resource groups."
  default     = "eastus2"
}

variable "VmSize" {
  description = "The VM_SKU to use for the agents in the cluster"
  default     = "Standard_DS1_v2"
}

variable "UserName" {
  type    = "string"
  default = "terraform"
}

variable "CloudInit" {
  default = "Config/install.sh"
}
