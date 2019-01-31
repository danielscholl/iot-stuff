/*
.Synopsis
   Terraform Output
.DESCRIPTION
   This file holds the outputs for the Terraform IoT Edge Gateway.
*/
#########################################################
# OUTPUT
#########################################################

output "configure" {
  value = <<CONFIGURE
Edge Device Access:
---------------------------------------------------------
$ ./edge.sh

Initialize Configuration and Create Edge Certificates:
---------------------------------------------------------
$ ./init.sh

Edge Device Configuration:
---------------------------------------------------------
$ ./configure.sh
CONFIGURE
}
