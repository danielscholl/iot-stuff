#!/usr/bin/env bash
#
#  Purpose: IoT Edge BootScript
#  Usage:
#    iot-edge.sh

echo "bootscript initiated" > /tmp/results.txt

# Install the repository configuration
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /tmp/microsoft-prod.list
sudo cp /tmp/microsoft-prod.list /etc/apt/sources.list.d/

# Install a public key to access the repository
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/microsoft.gpg
sudo cp /tmp/microsoft.gpg /etc/apt/trusted.gpg.d/

# Install Moby Engine and CLI
sudo apt-get update -y
sudo apt-get install apt-transport-https lsb-release ca-certificates curl software-properties-common

# Install the Azure CLI
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv \
     --keyserver packages.microsoft.com \
     --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF
sudo apt-get update -y
sudo apt-get install azure-cli
az extension add --name azure-cli-iot-ext

# Install Moby Engine and Moby CLI
sudo apt-get install moby-engine moby-cli -y
usermod -aG docker terraform

# Install the Security Daemon
sudo apt-get update
sudo apt-get install iotedge -y

echo "bootscript done" >> /tmp/results.txt

exit 0
