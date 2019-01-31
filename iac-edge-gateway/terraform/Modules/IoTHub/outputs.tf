##############################################################
# This module allows the creation of an IoT Hub
##############################################################

output "Name" {
  value = "${azurerm_iothub.module_iot.name}"
}
