##############################################################
# This module allows the creation of a Resource Group
##############################################################

output "Name" {
  value = "${azurerm_resource_group.module_resourcegroup.name}"
}

output "Location" {
  value = "${azurerm_resource_group.module_resourcegroup.location}"
}

output "Id" {
  value = "${azurerm_resource_group.module_resourcegroup.id}"
}

output "Unique" {
  value = "${random_id.randomId.hex}"
}
