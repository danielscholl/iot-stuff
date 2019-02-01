#!/usr/bin/env bash
#
#  Purpose: Initialize the environment
#  Usage:
#    build.sh

###############################
## ARGUMENT INPUT            ##
###############################

usage() { echo "Usage: build.sh <release> <group> <registry>" 1>&2; exit 1; }

if [ ! -z $1 ]; then RELEASE=$1; fi
if [ -z $RELEASE ]; then
  RELEASE="0.0.1"
fi

if [ ! -z $2 ]; then RESOURCE_GROUP=$2; fi
if [ -z $RESOURCE_GROUP ]; then
  RESOURCE_GROUP="IoTEdgeResources"
fi

if [ ! -z $3 ]; then REGISTRY=$3; fi
if [ -z $REGISTRY ]; then
  REGISTRY=$(az acr list --resource-group $RESOURCE_GROUP --query [].name -otsv)
fi

tput setaf 2; echo "Build and Deploy solution as ${RELEASE}-amd64 to ${REGISTRY}" ; tput sgr0

# Build File
cd modules
tput setaf 2; echo 'Executing the Container Registry Build' ; tput sgr0
az acr run -r $REGISTRY -f build.yaml .
