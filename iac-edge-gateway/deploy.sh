#!/usr/bin/env bash
#
#  Purpose: Initialize the environment
#  Usage:
#    deploy.sh

###############################
## ARGUMENT INPUT            ##
###############################
usage() { echo "Usage: deploy.sh <manifest>" 1>&2; exit 1; }

if [ ! -z $1 ]; then MANIFEST=$1; fi
if [ -z $MANIFEST ]; then
  MANIFEST=./manifests/tempSensor.json
fi

RESOURCE_GROUP="IoTEdgeResources"
EDGE_VM="EdgeVM"

IOT_HUB=$(az iot hub list \
  --resource-group ${RESOURCE_GROUP} \
  --query [].name -otsv)

echo "Deploying solution to ${EDGE_VM}"

az iot edge set-modules \
  --device-id ${EDGE_VM} \
  --hub-name ${IOT_HUB} \
  --content ${MANIFEST}
