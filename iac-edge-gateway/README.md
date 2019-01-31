# Infrastructure as Code IoT Edge Gateway

__Prerequisites__

* HashiCorp [Terraform](https://terraform.io/downloads.html) installed.

  ```bash
  export VER="0.11.8"
  wget https://releases.hashicorp.com/terraform/${VER}/terraform_${VER}_linux_amd64.zip
  unzip terraform_${VER}_linux_amd64.zip
  sudo mv terraform /usr/local/bin/
  ```

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed.

  >Assumes Ansible Version = ansible 2.7.6

  ```bash
    sudo easy_install pip
    sudo pip install ansible
  ```

__Setup Terraform Environment Variables__

Generate Azure client id and secret.

> After creating a Service Principal you __MUST__ add API access for _Windows Azure Active Directory_ and enable the following permissions
> - Read and write all applications
> - Sign in and read user profile

```bash
# Create a Service Principal
Subscription=$(az account show --query id -otsv)
az ad sp create-for-rbac --name "http://Terraform-Principal" --role="Owner" --scopes="/subscriptions/$Subscription"

# Expected Result
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "Terraform-Principal",
  "name": "http://Terraform-Principal",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
```
`appId` -> Client id.  
`password` -> Client secret.  
`tenant` -> Tenant id.

Export environment variables to configure the [Azure](https://www.terraform.io/docs/providers/azurerm/index.html) Terraform provider.

>A great tool to do this automatically with is [direnv](https://direnv.net/).

```bash
export ARM_SUBSCRIPTION_ID="YOUR_SUBSCRIPTION_ID"
export ARM_TENANT_ID="TENANT_ID"
export ARM_CLIENT_ID="CLIENT_ID"
export ARM_CLIENT_SECRET="CLIENT_SECRET"
export TF_VAR_client_id=${ARM_CLIENT_ID}
export TF_VAR_client_secret=${ARM_CLIENT_SECRET}
```

## Provisioning and Configuring the System

```bash
# Create the Azure Resources
./provision.sh

############
### -WARNING:  Due to a bug in Terraform you must manually 'enable' the fallback route
############

# Initialize a Device and Prepare the Configurations
./init.sh

# Configure the IoT Edge Device
./configure.sh
```

_[Terraform AzureRM Provider Issue #2764](https://github.com/terraform-providers/terraform-provider-azurerm/pull/2764)_

> Reference Links
  - [https://docs.microsoft.com/en-us/azure/iot-edge/about-iot-edge](https://docs.microsoft.com/en-us/azure/iot-edge/about-iot-edge)
  - [https://docs.microsoft.com/en-us/azure/iot-edge/quickstart-linux](https://docs.microsoft.com/en-us/azure/iot-edge/quickstart-linux)
  - [https://docs.microsoft.com/en-us/azure/iot-edge/iot-edge-as-gateway](https://docs.microsoft.com/en-us/azure/iot-edge/iot-edge-as-gateway)
