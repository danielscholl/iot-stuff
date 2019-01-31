##############################################################
# This module allows the creation of a Container Registry
##############################################################

data "azurerm_client_config" "current" {}

resource "azurerm_container_registry" "module_acr" {
  name                = "${var.RegistryName}"
  resource_group_name = "${var.ResourceGroup}"
  location            = "${var.Location}"
  admin_enabled       = true
  sku                 = "Basic"

  tags = {
    environment = "${var.Environment}"
  }
}

resource "azurerm_role_assignment" "module_acr" {
  scope                = "${azurerm_container_registry.module_acr.id}"
  role_definition_name = "Reader"
  principal_id         = "${data.azurerm_client_config.current.service_principal_application_id}"
}
