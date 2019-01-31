# Helpful Azure CLI IoT Snippets

__Prerequisites__

* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) installed.

  >Assumes CLI Version = azure-cli (2.0.54)  ** Required for RBAC changes

  ```bash
  az extension add --name azure-cli-iot-ext
  ```

### Creating a IoT Hub

```bash
# Using Bash
ResourceGroup="IoTtest" Location="eastus"
Tier="F1"
Hub="cli-hub" Device="DirectDevice"

# Using Powershell
$ResourceGroup,$Location="IoTtest","eastus"
$Tier="F1"
$Hub,$Device="cli-hub","DirectDevice"

# Create a hub
az group create --resource-group $ResourceGroup --location $Location
az iot hub create --resource-group $ResourceGroup --location $Location --name $Hub --sku $Tier 

# Create a Device
az iot hub device-identity create --hub-name $Hub --device-id $Device
```

### Sending D2C Messages

_Monitor IoT Hub Events in Terminal Window 1_

```bash
Hub="cli-hub" Device="DirectDevice"    # Using Bash
$Hub,$Device="cli-hub","DirectDevice"  # Using Powershell

# Monitor Hub for Device Events
az iot hub monitor-events --hub-name $Hub --device-id $Device
```

_Send Device to Cloud Messages in Terminal Window 2_

```bash
Hub="cli-hub" Device="DirectDevice"    # Using Bash
$Hub,$Device="cli-hub","DirectDevice"  # Using Powershell

# Send a Single Device to Cloud Message
az iot device send-d2c-message --hub-name $Hub --device-id $Device \
    --data "Hello Hub"

# Send messages from the Device Simulator
az iot device simulate --hub-name $Hub --device-id $Device \
    --data "Hello Hub"
```

### Sending C2D Messages

_Monitor for Device Events in Terminal Window 1_

```bash
Hub="cli-hub" Device="DirectDevice"    # Using Bash
$Hub,$Device="cli-hub","DirectDevice"  # Using Powershell

# Monitor Device for Cloud Events
az iot device c2d-message receive --hub-name $Hub --device-id $Device -ojsonc
```


_Send Cloud to Device Messages in Terminal Window 2_

```bash
Hub="cli-hub" Device="DirectDevice"    # Using Bash
$Hub,$Device="cli-hub","DirectDevice"  # Using Powershell

# Send a Single Device to Cloud Message
az iot device c2d-message send --hub-name $Hub --device-id $Device \
    --data "Hello Device"
```


### Simulating a Device

_Monitor IoT Hub Events in Terminal Window 1_

```bash
Hub="cli-hub" Device="DirectDevice"    # Using Bash
$Hub,$Device="cli-hub","DirectDevice"  # Using Powershell

# Monitor Hub for Device Events
az iot hub monitor-events --hub-name $Hub --device-id $Device
```


_Simulate Device Sending Events in Terminal Window 2_

```bash
Hub="cli-hub" Device="DirectDevice"    # Using Bash
$Hub,$Device="cli-hub","DirectDevice"  # Using Powershell

# Send messages from the Device Simulator
az iot device simulate --hub-name $Hub --device-id $Device \
    --data "Hello from simulator" \
    --msg-count 10 \
    --msg-interval 10
```


_Send Cloud to Device Messages in Terminal Window 3_

```bash
Hub="cli-hub" Device="DirectDevice"    # Using Bash
$Hub,$Device="cli-hub","DirectDevice"  # Using Powershell

# Send a Single Cloud to Device Message
az iot device c2d-message send --hub-name $Hub --device-id $Device \
    --data "Hello Device"
```
