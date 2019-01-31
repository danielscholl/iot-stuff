##############################################################
# This module allows the creation of an IoT Edge
##############################################################

data "template_file" "cloudconfig" {
  template = "${file("${path.root}/${var.CloudInitPath}")}"
}

#https://www.terraform.io/docs/providers/template/d/cloudinit_config.html
data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content = "${data.template_file.cloudconfig.rendered}"
  }
}

resource "azurerm_public_ip" "module_iotedge" {
  name                         = "${var.VmName}-ip"
  resource_group_name          = "${var.ResourceGroup}"
  location                     = "${var.Location}"
  public_ip_address_allocation = "dynamic"

  tags = {
    environment = "${var.Environment}"
  }
}

resource "azurerm_network_interface" "module_iotedge" {
  name                = "${var.VmName}-nic"
  resource_group_name = "${var.ResourceGroup}"
  location            = "${var.Location}"

  ip_configuration {
    name                          = "nicConfiguration"
    subnet_id                     = "${var.VNetId}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.module_iotedge.id}"
  }

  tags = {
    environment = "${var.Environment}"
  }
}

resource "azurerm_storage_account" "module_iotedge" {
  name                     = "diag${var.Unique}"
  resource_group_name      = "${var.ResourceGroup}"
  location                 = "${var.Location}"
  account_replication_type = "LRS"
  account_tier             = "Standard"

  tags = {
    environment = "${var.Environment}"
  }
}

resource "azurerm_virtual_machine" "module_iotedge" {
  name                  = "${var.VmName}"
  resource_group_name   = "${var.ResourceGroup}"
  location              = "${var.Location}"
  network_interface_ids = ["${azurerm_network_interface.module_iotedge.id}"]
  vm_size               = "${var.VmSize}"

  storage_os_disk {
    name              = "${var.VmName}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.VmName}"
    admin_username = "${var.UserName}"
    custom_data    = "${data.template_cloudinit_config.config.rendered}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.UserName}/.ssh/authorized_keys"
      key_data = "${trimspace(var.PublicKey)} ${var.UserName}@azure.com"
    }
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${azurerm_storage_account.module_iotedge.primary_blob_endpoint}"
  }

  tags = {
    environment = "${var.Environment}"
  }
}
