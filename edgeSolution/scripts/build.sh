#!/usr/bin/env bash
#
#  Purpose: Initialize the environment
#  Usage:
#    build.sh

###############################
## ARGUMENT INPUT            ##
###############################

usage() { echo "Usage: build.sh registry <release>" 1>&2; exit 1; }

if [ ! -z $1 ]; then RELEASE=$1; fi
if [ -z $RELEASE ]; then
  RELEASE="0.0.1"
fi

if [ ! -z $2 ]; then REGISTRY=$2; fi
if [ -z $REGISTRY ]; then
  REGISTRY=$CONTAINER_REGISTRY_USERNAME
fi

tput setaf 2; echo 'Build and Deploy solution as ${RELEASE}-amd64 to ${REGISTRY}' ; tput sgr0

# Build File
cd modules
tput setaf 2; echo 'Executing the Container Registry Build' ; tput sgr0
az acr run -r $REGISTRY -f build.yaml .
