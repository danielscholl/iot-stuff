##############################################################
# This module allows the creation of a VNet
##############################################################

data "azurerm_client_config" "current" {}

resource "azurerm_network_security_group" "module_network_1" {
  name                = "${var.Nsg1Name}"
  resource_group_name = "${var.ResourceGroup}"
  location            = "${var.Location}"

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
    description                = "ssh-for-vm-management"
  }

  tags = {
    environment = "${var.Environment}"
  }
}

resource "azurerm_virtual_network" "module_network" {
  name                = "${var.VNetName}"
  resource_group_name = "${var.ResourceGroup}"
  location            = "${var.Location}"
  address_space       = "${var.AddressSpace}"
  dns_servers         = []

  tags = {
    environment = "${var.Environment}"
  }
}

resource "azurerm_subnet" "module_network_1" {
  name                 = "${var.Subnet1Name}"
  resource_group_name  = "${var.ResourceGroup}"
  virtual_network_name = "${azurerm_virtual_network.module_network.name}"
  address_prefix       = "${var.Subnet1Prefix}"
}

resource "azurerm_subnet_network_security_group_association" "module_network_1" {
  subnet_id                 = "${azurerm_subnet.module_network_1.id}"
  network_security_group_id = "${azurerm_network_security_group.module_network_1.id}"
}

resource "azurerm_role_assignment" "module_network" {
  scope                = "${azurerm_subnet.module_network_1.id}"
  role_definition_name = "Contributor"
  principal_id         = "${data.azurerm_client_config.current.service_principal_application_id}"
}
