##############################################################
# This module allows the creation of a VNet
##############################################################

output "Name" {
  value = "${azurerm_virtual_network.module_network.name}"
}

output "Id" {
  value = "${azurerm_virtual_network.module_network.id}"
}

output "Subnet1Id" {
  value = "${azurerm_subnet.module_network_1.id}"
}
