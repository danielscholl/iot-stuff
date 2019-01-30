# Simple Device

## Docker

1. Build the Container(s)

  `docker-compose build`

2. Run the Container(s)

  ```bash
  Hub="cli-hub" DEVICE_JS="DirectDevice-JS" DEVICE_NET="DirectDevice-NET"

  # Create Devices as necessary
  az iot hub device-identity create --hub-name $Hub --device-id $DEVICE_JS
  az iot hub device-identity create --hub-name $Hub --device-id $DEVICE_NET

  # Export the required Environment variables
  export DEVICE_JS="DirectDevice-JS" DEVICE_NET="DirectDevice-NET"
  export DEVICE_JS_CONNECTION=$(az iot hub device-identity show-connection-string --hub-name $Hub --device-id $DEVICE_JS -otsv)
  export DEVICE_NET_CONNECTION=$(az iot hub device-identity show-connection-string --hub-name $Hub --device-id $DEVICE_NET -otsv)

  # Build the Docker Containers
  docker-compose build

  # Run the Docker Containers
  docker-compose up

  # Adjust the Interval Spped
  Data="{ methodName: 'SetTelemetryInterval', payload: 10, responseTimeoutInSeconds: 30 }"
  az iot device c2d-message send --hub-name $Hub --device-id $DEVICE_JS --data $Data
}
  ```
