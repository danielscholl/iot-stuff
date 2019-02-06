# SimpleDevice

> The code base is driven off of environment variable settings.  A convenient way to set these is using [direnv](https://github.com/direnv/direnv) and then setting up the .envrc file.  _See the sample .envrc_sample_


__Build the Container(s)__

  ```bash
  docker-compose build
  ```

__Run the Container(s)__

  ```bash
  Hub="cli-hub" DEVICE_JS="DirectDevice-JS" DEVICE_NET="DirectDevice-NET"

  # Create Devices as necessary
  az iot hub device-identity create --hub-name $Hub --device-id $DEVICE_JS
  az iot hub device-identity create --hub-name $Hub --device-id $DEVICE_NET

  # Export the required Environment variables
  export DEVICE_JS="DirectDevice-JS" DEVICE_NET="DirectDevice-NET"
  export DEVICE_JS_CONNECTION=$(az iot hub device-identity show-connection-string --hub-name $Hub --device-id $DEVICE_JS -otsv)
  export DEVICE_NET_CONNECTION=$(az iot hub device-identity show-connection-string --hub-name $Hub --device-id $DEVICE_NET -otsv)

  # Build and Run the Docker Containers
  docker-compose up --build
  ```

> Reference Links
  - [https://docs.microsoft.com/en-us/azure/iot-hub/quickstart-send-telemetry-dotnet](https://docs.microsoft.com/en-us/azure/iot-hub/quickstart-send-telemetry-dotnet)
  - [https://docs.microsoft.com/en-us/azure/iot-hub/quickstart-send-telemetry-node](https://docs.microsoft.com/en-us/azure/iot-hub/quickstart-send-telemetry-node)


docker run \
  -e "DEVICE=$DEVICE_JS" \
  -e "DEVICE_CONNECTION_STRING=$DEVICE_JS_CONNECTION" \
  -v "$(pwd)/js/cert/:/usr/src/app/cert" \
  localhost:5000/iot-device-js:latest
