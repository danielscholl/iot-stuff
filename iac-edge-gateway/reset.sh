#
#  Purpose: Clean up Delete and Reset the environment
#  Usage:
#    reset.sh

###############################
## ARGUMENT INPUT            ##
###############################
usage() { echo "Usage: reset.sh ssh" 1>&2; exit 1; }

if [ ! -z $1 ]; then SSH_DELETE=$1; fi
if [ -z $SSH_DELETE ]; then
  SSH_DELETE=false
fi

function rmFile() {
  # Required Argument $1 = FILE

  if [ -z $1 ]; then
    tput setaf 1; echo 'ERROR: Argument $1 (FILE) not received' ; tput sgr0
    exit 1;
  fi

  if [ -f $1 ]; then rm $1; fi
}

function rmDirectory() {
  # Required Argument $1 = DIRECTORY

  if [ -z $1 ]; then
    tput setaf 1; echo 'ERROR: Argument $1 (DIRECTORY) not received' ; tput sgr0
    exit 1;
  fi

  if [ -d $1 ]; then rm -rf $1; fi
}

##############################
## Remove Azure Resources ##
##############################

tput setaf 2; echo 'Cleaning up the Azure Resources' ; tput sgr0
RESOURCE_GROUP="IoTEdgeResources"

_result=$(az group show --name $RESOURCE_GROUP)
if [ "$_result"  != "" ]; then
  tput setaf 2; echo 'Removing the Resource Group' ; tput sgr0
    az group delete \
      --name $RESOURCE_GROUP \
      --no-wait --yes
fi

##############################
## Clean Up Device Files ##
##############################

DIR_DEVICE_LIBRARIES="./device/node_modules"
FILE_DEVICE_ENV="./device/.envrc"
FILE_DEVICE_BUILD="./device/build.yaml"

tput setaf 2; echo 'Cleaning up the Device Resources' ; tput sgr0
rmDirectory $DIR_DEVICE_LIBRARIES
rmFile $FILE_DEVICE_ENV
rmFile $FILE_DEVICE_BUILD

##############################
## Clean Up Solution Files ##
##############################

DIR_SOLUTION_CONFIG="./edgeSolution/config"
DIR_SOLUTION_OBJ="./edgeSolution//modules/filterModule/obj"
DIR_SOLUTION_BIN="./edgeSolution/modules/filterModule/bin"
FILE_SOLUTION_ENV="./edgeSolution/.env"
FILE_SOLUTION_BUILD="./edgeSolution/build.yaml"

tput setaf 2; echo 'Cleaning up the Solution Resources' ; tput sgr0
rmDirectory $DIR_SOLUTION_CONFIG
rmDirectory $DIR_SOLUTION_OBJ
rmDirectory $DIR_SOLUTION_BIN
rmFile $FILE_SOLUTION_ENV
rmFile $FILE_SOLUTION_BUILD

##############################
## Clean Up Ansible Files ##
##############################

FILE_ANSIBLE_HOSTS="./ansible/inventories/azure/hosts"
FILE_ANSIBLE_VARS="./ansible/inventories/azure/group_vars/all"
FILE_ANSIBLE_CFG="./ansible.cfg"
DIR_ANSIBLE_EDGE_CERTS="./ansible/playbooks/roles/iotEdge/files"

tput setaf 2; echo 'Cleaning up the Ansible Resources' ; tput sgr0
rmFile $FILE_ANSIBLE_HOSTS
rmFile $FILE_ANSIBLE_VARS
rmFile $FILE_ANSIBLE_CFG
rmDirectory $DIR_ANSIBLE_EDGE_CERTS


##############################
## Clean Up Certficates ##
##############################

DIR_CERTS_CERTS="./certs/certs"
DIR_CERTS_CSR="./certs/csr"
DIR_CERTS_INTERMEDIATECERTS="./certs/intermediateCerts"
DIR_CERTS_NEWCERTS="./certs/newcerts"
DIR_CERTS_PRIVATE="./certs/private"
FILE_INDEX="./certs/index.txt"
FILE_INDEXOLD="./certs/index.txt.old"
FILE_INDEXATTR="./certs/index.txt.attr"
FILE_INDEXATTROLD="./certs/index.txt.attr.old"
FILE_SERIAL="./certs/serial"
FILE_SERIALOLD="./certs/serial.old"

tput setaf 2; echo 'Cleaning up the Certificate Resources' ; tput sgr0
rmDirectory $DIR_CERTS_CERTS
rmDirectory $DIR_CERTS_CSR
rmDirectory $DIR_CERTS_INTERMEDIATECERTS
rmDirectory $DIR_CERTS_NEWCERTS
rmDirectory $DIR_CERTS_PRIVATE
rmFile $FILE_INDEX
rmFile $FILE_INDEXOLD
rmFile $FILE_INDEXATTR
rmFile $FILE_INDEXATTROLD
rmFile $FILE_SERIAL
rmFile $FILE_SERIALOLD


##############################
## Clean Up Terraform Files ##
##############################

DIR_TERRAFORM="./terraform/.terraform"
FILE_TERRAFORM_STATE="./terraform/terraform.tfstate"
FILE_TERRAFORM_STATE_BU="./terraform/terraform.tfstate.backup"
DIR_SSH="./terraform/.ssh"

tput setaf 2; echo 'Cleaning up the Terraform Resources' ; tput sgr0
rmDirectory $DIR_TERRAFORM
if [ $SSH_DELETE == "ssh" ]; then rmDirectory $DIR_SSH; fi
rmFile $FILE_TERRAFORM_STATE
rmFile $FILE_TERRAFORM_STATE_BU
