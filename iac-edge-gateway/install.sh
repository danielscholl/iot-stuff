#!/usr/bin/env bash
#
#  Purpose: Install the IoT Edge
#  Usage:
#    install.sh

###############################
## ARGUMENT INPUT            ##
###############################

usage() { echo "Usage: install.sh " 1>&2; exit 1; }

if [ -f ./.envrc ]; then source ./.envrc; fi

##############################
## Create Ansible Inventory ##
##############################

RESOURCE_GROUP="IoTEdgeResources"
EDGE_VM="EdgeVM"
SIMULATOR="EdgeSimulator"
DEVICE_NAME="DirectDevice"
LINUX_USER="terraform"
INVENTORY="./ansible/inventories/azure/"
GLOBAL_VARS="./ansible/inventories/azure/group_vars"
mkdir -p ${INVENTORY};
mkdir -p ${GLOBAL_VARS}

tput setaf 2; echo "Retrieving Required Information ..." ; tput sgr0

TENANT=$(az account show \
  --query tenantId \
  -otsv)

LB_IP=$(az network public-ip show \
  --resource-group ${RESOURCE_GROUP} \
  --name EdgeVM-ip \
  --query ipAddress \
  -otsv)

IOT_HUB=$(az iot hub list \
  --resource-group ${RESOURCE_GROUP} \
  --query [].name -otsv)

EDGE_DEVICE=$(az iot hub device-identity show \
  --hub-name ${IOT_HUB} \
  --device-id ${EDGE_VM} \
  --query deviceId \
  -otsv)

if [ "$EDGE_DEVICE" == "" ]
then
  tput setaf 2; echo "Creating Edge Device ..." ; tput sgr0
  EDGE_DEVICE=$(az iot hub device-identity create \
    --hub-name ${IOT_HUB} \
    --device-id ${EDGE_VM} \
    --edge-enabled \
    --query deviceId \
    -otsv)
fi

EDGE_SIMULATOR=$(az iot hub device-identity show \
  --hub-name ${IOT_HUB} \
  --device-id ${SIMULATOR} \
  --query deviceId \
  -otsv)

if [ "$EDGE_SIMULATOR" == "" ]
then
  tput setaf 2; echo "Creating Edge Simulator ..." ; tput sgr0
  EDGE_SIMULATOR=$(az iot hub device-identity create \
    --hub-name ${IOT_HUB} \
    --device-id ${SIMULATOR} \
    --edge-enabled \
    --query deviceId \
    -otsv)
fi

EDGE_LEAF=$(az iot hub device-identity show \
  --hub-name ${IOT_HUB} \
  --device-id ${EDGE_VM}-leaf \
  --query deviceId \
  -otsv)

if [ "$EDGE_LEAF" == "" ]
then
  tput setaf 2; echo "Creating Edge Leaf ..." ; tput sgr0
  EDGE_LEAF=$(az iot hub device-identity create \
    --hub-name ${IOT_HUB} \
    --device-id ${EDGE_VM}-leaf \
    --query deviceId \
    -otsv)
fi

DIRECT_DEVICE=$(az iot hub device-identity show \
  --hub-name ${IOT_HUB} \
  --device-id ${DEVICE_NAME} \
  --query deviceId \
  -otsv)

if [ "$DIRECT_DEVICE" == "" ]
then
  tput setaf 2; echo "Creating Direct Connect Device ..." ; tput sgr0
  DIRECT_DEVICE=$(az iot hub device-identity create \
    --hub-name ${IOT_HUB} \
    --device-id ${DEVICE_NAME} \
    --query deviceId \
    -otsv)
fi

PRIMARY_KEY=$(az iot hub device-identity show \
  --resource-group ${RESOURCE_GROUP} \
  --hub-name ${IOT_HUB} \
  --device-id ${EDGE_VM} \
  --query authentication.symmetricKey.primaryKey -otsv)

# Certificates

DIR_ANSIBLE_EDGE_CERTS="./ansible/playbooks/roles/iotEdge/files"
if [ ! -d $DIR_ANSIBLE_EDGE_CERTS ]; then
  mkdir $DIR_ANSIBLE_EDGE_CERTS
fi

cd certs

if [ ! -f ./certs/azure-iot-test-only.chain.ca.cert.pem ]
then
  tput setaf 2; echo 'Creating the Root and Intermediate Certificates...' ; tput sgr0
  ./certGen.sh create_root_and_intermediate
fi

if [ ! -f ../ansible/playbooks/roles/iotEdge/files/azure-iot.root.ca.crt ]
then
  tput setaf 2; echo 'Copying the Root and Intermediate Certificates...' ; tput sgr0
  cp ./certs/azure-iot-test-only.root.ca.cert.pem ../ansible/playbooks/roles/iotEdge/files/azure-iot.root.ca.crt
fi

if [ ! -f ./certs/new-edge-device.cert.pem ]
then
  tput setaf 2; echo 'Creating the IoT Edge Device Certificates...' ; tput sgr0
  ./certGen.sh create_edge_device_certificate ${EDGE_VM}ca
  cat ./certs/new-edge-device.cert.pem ./certs/azure-iot-test-only.intermediate.cert.pem ./certs/azure-iot-test-only.root.ca.cert.pem > ./certs/new-edge-device-full-chain.cert.pem
fi


if [ ! -f ../ansible/playbooks/roles/iotEdge/files/${EDGE_DEVICE}.cert.pem ]
then
  tput setaf 2; echo 'Copying the IoT Edge Device Certificates...' ; tput sgr0
  cp ./certs/new-edge-device-full-chain.cert.pem  ../ansible/playbooks/roles/iotEdge/files/${EDGE_DEVICE}.cert.pem
fi

if [ ! -f ../ansible/playbooks/roles/iotEdge/files/${EDGE_DEVICE}.key.pem ]
then
  tput setaf 2; echo 'Copying the IoT Edge Device Key...' ; tput sgr0
  cp ./private/new-edge-device.key.pem ../ansible/playbooks/roles/iotEdge/files/${EDGE_DEVICE}.key.pem
fi


if [ ! -f ./certs/new-device.cert.pem ]
then
  tput setaf 2; echo 'Creating the IoT Leaf Device Certificates...' ; tput sgr0
  ./certGen.sh create_device_certificate ${EDGE_VM}-leaf
  cat ./certs/new-device.cert.pem ./certs/azure-iot-test-only.intermediate.cert.pem ./certs/azure-iot-test-only.root.ca.cert.pem > ./certs/new-device-full-chain.cert.pem
fi

if [ ! -f ../ansible/playbooks/roles/iotEdge/files/${EDGE_DEVICE}-leaf.cert.pem ]
then
  tput setaf 2; echo 'Copying the IoT Leaf Device Certificates...' ; tput sgr0
  cp ./certs/new-device-full-chain.cert.pem  ../ansible/playbooks/roles/iotEdge/files/${EDGE_DEVICE}-leaf.cert.pem
fi

if [ ! -f ../ansible/playbooks/roles/iotEdge/files/${EDGE_DEVICE}-leaf.key.pem ]
then
  tput setaf 2; echo 'Copying the IoT Leaf Device Keys...' ; tput sgr0
  cp ./private/new-device.key.pem ../ansible/playbooks/roles/iotEdge/files/${EDGE_DEVICE}-leaf.key.pem
fi

cd ..

# Ansible Inventory
tput setaf 2; echo 'Creating the ansible inventory files...' ; tput sgr0
cat > ${INVENTORY}/hosts << EOF
$(echo "EdgeVM ansible_host=$LB_IP ansible_user=$LINUX_USER")

[IoTEdge]
$(echo "$EDGE_VM")
EOF

# Ansible Config
tput setaf 2; echo 'Creating the ansible config file...' ; tput sgr0
cat > ansible.cfg << EOF1
[defaults]
inventory = ${INVENTORY}/hosts
private_key_file = ./terraform/.ssh/id_rsa
host_key_checking = false
EOF1

# Ansible Global VARS
tput setaf 2; echo 'Creating the global vars file...' ; tput sgr0
cat > ${GLOBAL_VARS}/all << EOF2
---
azure_iot_hub_name: ${IOT_HUB}
azure_edge_name: ${EDGE_VM}

azure_groups:
  ${EDGE_VM}:
    primaryKey: ${PRIMARY_KEY}
EOF2


# Solution .env

IOT_HUB_CS=$(az iot hub show-connection-string \
  --resource-group ${RESOURCE_GROUP} \
  --hub-name ${IOT_HUB} \
  -otsv )

EDGE_DEVICE_CS=$(az iot hub device-identity show-connection-string \
  --hub-name ${IOT_HUB} \
  --device-id ${EDGE_VM} \
  -otsv)

EDGE_SIMULATOR_CS=$(az iot hub device-identity show-connection-string \
  --hub-name ${IOT_HUB} \
  --device-id ${EDGE_SIMULATOR} \
  -otsv)

REGISTRY_SERVER=$(az acr list \
  --resource-group=${RESOURCE_GROUP} \
  --query [].loginServer \
  -otsv)

REGISTRY_NAME=$(az acr list \
  --resource-group=${RESOURCE_GROUP} \
  --query [].name \
  -otsv)

REGISTRY_USERNAME=$(az acr credential show \
  --name ${REGISTRY_NAME} \
  --query username \
  -otsv)

REGISTRY_PASSWORD=$(az acr credential show \
  --name ${REGISTRY_NAME}  \
  --query passwords[0].value \
  -otsv)

tput setaf 2; echo 'Creating the solution .env file...' ; tput sgr0

cat > ../edgeSolution/.env << EOF3
# CONNECTION STRINGS
IOTHUB_CONNECTION_STRING="${IOT_HUB_CS}"
DEVICE_CONNECTION_STRING="${EDGE_DEVICE_CS}"
SIMULATOR_CONNECTION_STRING="${EDGE_SIMULATOR_CS}"

# CONTAINER REGISTRY
CONTAINER_REGISTRY_SERVER="${REGISTRY_SERVER}"
CONTAINER_REGISTRY_USERNAME="${REGISTRY_USERNAME}"
CONTAINER_REGISTRY_PASSWORD="${REGISTRY_PASSWORD}"

EOF3

ansible all -m ping
ansible-playbook ansible/playbooks/main.yml
