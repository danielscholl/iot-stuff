##############################################################
# This module allows the creation of an IoT Hub
##############################################################

resource "azurerm_storage_account" "module_iothub" {
  name                     = "iot${var.Unique}"
  resource_group_name      = "${var.ResourceGroup}"
  location                 = "${var.Location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "${var.Environment}"
  }
}

resource "azurerm_storage_container" "module_iothub" {
  name                  = "iot"
  resource_group_name   = "${var.ResourceGroup}"
  storage_account_name  = "${azurerm_storage_account.module_iothub.name}"
  container_access_type = "private"
}

resource "azurerm_iothub" "module_iot" {
  name                = "hub${var.Unique}"
  resource_group_name = "${var.ResourceGroup}"
  location            = "${var.Location}"

  sku {
    name     = "S1"
    tier     = "Standard"
    capacity = "1"
  }

  tags = {
    environment = "${var.Environment}"
  }
}
