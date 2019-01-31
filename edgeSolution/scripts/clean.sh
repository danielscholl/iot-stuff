#!/usr/bin/env bash
#
#  Purpose: Initialize the environment
#  Usage:
#    clean.sh

###############################
## ARGUMENT INPUT            ##
###############################
usage() { echo "Usage: clean.sh" 1>&2; exit 1; }

if [ ! -z $1 ]; then RESOURCE_GROUP=$1; fi
if [ -z $RESOURCE_GROUP ]; then
  RESOURCE_GROUP="IoTEdgeResources"
fi

if [ ! -z $2 ]; then EDGE_VM=$2; fi
if [ -z $EDGE_VM ]; then
  EDGE_VM="EdgeVM"
fi


IOT_HUB=$(az iot hub list \
  --resource-group ${RESOURCE_GROUP} \
  --query [].name -otsv)

echo "Deploying modules to ${EDGE_VM}"

az iot edge set-modules \
  --device-id ${EDGE_VM} \
  --hub-name ${IOT_HUB} \
  --content deployment.clean.json
