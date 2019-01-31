/*
.Synopsis
   Terraform Main Control
.DESCRIPTION
   This file holds the main control and resoures for the Terraform Linux IoT Edge Quickstart.
*/

provider "azurerm" {
  version = "=1.21.0"
}

variable "client_id" {}
variable "client_secret" {}

resource "random_integer" "unique" {
  # 3 Digit Random Number Generator
  min = 100
  max = 999
}

locals {
  unique                  = "${random_integer.unique.result}"
  rg_name                 = "IoTEdgeResources"
  vnet_name               = "IoTEdge-vnet"
  container_subnet_name   = "ContainerSubnet"
  container_subnet_prefix = "10.0.0.0/20"
  container_nsg_name      = "${local.vnet_name}-${local.container_subnet_name}-nsg"
  edge_subnet_name        = "EdgeSubnet"
  edge_subnet_address     = "10.0.16.0/24"
  edge_nsg_name           = "${local.vnet_name}-${local.edge_subnet_name}-nsg"
  vm_name                 = "EdgeVM"
  ip_name                 = "${local.vm_name}-ip"
  nic_name                = "${local.vm_name}-nic"
}

#-------------------------------
# SSH Keys
#-------------------------------
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "null_resource" "save-key" {
  triggers {
    key = "${tls_private_key.key.private_key_pem}"
  }

  provisioner "local-exec" {
    command = <<EOF
      mkdir -p ${path.module}/.ssh
      echo "${tls_private_key.key.private_key_pem}" > ${path.module}/.ssh/id_rsa
      echo "${trimspace(tls_private_key.key.public_key_openssh)} ${var.UserName}@azure.com" > ${path.module}/.ssh/id_rsa.pub
      chmod 0600 ${path.module}/.ssh/id_rsa
EOF
  }
}

#-------------------------------
# Resource Group
#-------------------------------
module "ResourceGroup" {
  # Module Path
  source = "./Modules/ResourceGroup"

  # Module variable
  ResourceGroup = "${local.rg_name}"
  Location      = "${var.Location}"
  Environment   = "${var.Environment}"
}

# -------------------------------
# Network
# -------------------------------
module "Network" {
  # Module Path
  source = "./Modules/Network"

  # Module variable
  ResourceGroup = "${module.ResourceGroup.Name}"
  Location      = "${var.Location}"
  VNetName      = "${local.vnet_name}"
  Subnet1Name   = "${local.container_subnet_name}"
  Nsg1Name      = "${local.container_nsg_name}"
  Environment   = "${var.Environment}"
}

#-------------------------------
# Container Registry
#-------------------------------
module "Registry" {
  # Module Path
  source = "./Modules/Registry"

  # Module variable
  ResourceGroup = "${module.ResourceGroup.Name}"
  Location      = "${var.Location}"
  RegistryName  = "acr${module.ResourceGroup.Unique}"
  Environment   = "${var.Environment}"
  ClientId      = "${var.client_id}"
}

#-------------------------------
# IoT Hub
#-------------------------------
module "IoTHub" {
  # Module Path
  source = "./Modules/IoTHub"

  # Module variable
  ResourceGroup = "${module.ResourceGroup.Name}"
  Unique        = "${module.ResourceGroup.Unique}"
  Location      = "${var.Location}"
  Environment   = "${var.Environment}"
}

#-------------------------------
# IoT Edge VM
#-------------------------------
module "IoTEdge" {
  # Module Path
  source = "./Modules/IoTEdge"

  # Module variable
  ResourceGroup = "${module.ResourceGroup.Name}"
  Unique        = "${module.ResourceGroup.Unique}"
  Location      = "${var.Location}"
  VNetId        = "${module.Network.Subnet1Id}"
  VmName        = "${local.vm_name}"
  VmSize        = "${var.VmSize}"
  PublicKey     = "${tls_private_key.key.public_key_openssh}"
  CloudInitPath = "${var.CloudInit}"
  Environment   = "${var.Environment}"
}
