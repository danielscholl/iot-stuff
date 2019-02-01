#!/usr/bin/env bash
#
#  Purpose: Initialize the environment
#  Usage:
#    init.sh

###############################
## ARGUMENT INPUT            ##
###############################
usage() { echo "Usage: init.sh <Hub_Resource_Group> <Registry_Server> <Edge_VM> " 1>&2; exit 1; }

if [ ! -z $1 ]; then RESOURCE_GROUP=$1; fi
if [ -z $RESOURCE_GROUP ]; then
  RESOURCE_GROUP="IoTEdgeResources"
fi

if [ ! -z $2 ]; then EDGE_VM=$2; fi
if [ -z $REGISTRY_NAME ]; then
  REGISTRY_NAME=$(az acr list --resource-group $RESOURCE_GROUP --query [].name -otsv)
fi


IOT_HUB=$(az iot hub list \
  --resource-group ${RESOURCE_GROUP} \
  --query [].name -otsv)

IOT_HUB_CS=$(az iot hub show-connection-string \
  --resource-group ${RESOURCE_GROUP} \
  --hub-name ${IOT_HUB} \
  -otsv )

REGISTRY_SERVER=$(az acr list \
  --query "[?name=='${REGISTRY_NAME}'].loginServer" \
  -otsv)

REGISTRY_USERNAME=$(az acr credential show \
  --name ${REGISTRY_NAME} \
  --query username \
  -otsv)

REGISTRY_PASSWORD=$(az acr credential show \
  --name ${REGISTRY_NAME}  \
  --query passwords[0].value \
  -otsv)

tput setaf 2; echo 'Creating the solution .envrc file...' ; tput sgr0

cat > .env << EOF
# CONNECTION STRINGS
IOTHUB_CONNECTION_STRING="${IOT_HUB_CS}"

# CONTAINER REGISTRY
CONTAINER_REGISTRY_SERVER="${REGISTRY_SERVER}"
CONTAINER_REGISTRY_USERNAME="${REGISTRY_USERNAME}"
CONTAINER_REGISTRY_PASSWORD="${REGISTRY_PASSWORD}"

EOF
