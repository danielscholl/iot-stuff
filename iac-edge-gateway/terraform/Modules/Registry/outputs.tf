##############################################################
# This module allows the creation of a Container Registry
##############################################################

output "Name" {
  value = "${azurerm_container_registry.module_acr.name}"
}

output "Id" {
  value = "${azurerm_container_registry.module_acr.id}"
}

output "ResourceGroup" {
  value = "${azurerm_container_registry.module_acr.resource_group_name}"
}

output "Location" {
  value = "${azurerm_container_registry.module_acr.location}"
}
