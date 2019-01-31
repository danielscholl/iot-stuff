#!/usr/bin/env bash
#
#  Purpose: SSH Connect to the Azure Virtual Machine
#  Usage:
#    connect.sh


#////////////////////////////////
RESOURCE_GROUP="IoTEdgeResources"
EDGE_VM="EdgeVM"
USER="terraform"
SSH_KEY="terraform/.ssh/id_rsa"

echo "Retrieving IP Address for ${EDGE_VM} in " ${RESOURCE_GROUP}
IP=$(az network public-ip show --resource-group ${RESOURCE_GROUP} --name ${EDGE_VM}-ip --query ipAddress -otsv)
echo 'Connecting to' $USER@$IP

ssh -i ${SSH_KEY} $USER@$IP -A
