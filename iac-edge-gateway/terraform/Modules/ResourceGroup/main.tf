##############################################################
# This module allows the creation of a Resource Group
##############################################################

resource "azurerm_resource_group" "module_resourcegroup" {
  name     = "${var.ResourceGroup}"
  location = "${var.Location}"

  tags = {
    environment = "${var.Environment}"
  }
}

resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = "${azurerm_resource_group.module_resourcegroup.name}"
  }

  byte_length = 8
}
