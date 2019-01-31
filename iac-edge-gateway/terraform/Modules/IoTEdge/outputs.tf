##############################################################
# This module allows the creation of an IoT Edge
##############################################################

output "Name" {
  value = "${azurerm_virtual_machine.module_iotedge.name}"
}

output "Id" {
  value = "${azurerm_virtual_machine.module_iotedge.id}"
}

output "public_ip_address" {
  description = "The Public IP Address Resource for the VM"
  value       = "${azurerm_public_ip.module_iotedge.ip_address}"
}

output "custom_data" {
  value = "${data.template_file.cloudconfig.rendered}"
}
