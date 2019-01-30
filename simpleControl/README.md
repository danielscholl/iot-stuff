# Simple Control

## Docker

1. Build the Container(s)

  `docker build -t localhost:5000/iot-control-js:latest -f ./js/Dockerfile ./js`

2. Run the Container(s)

  ```bash
  Hub="cli-hub" DEVICE_JS="DirectDevice-JS" DEVICE_NET="DirectDevice-NET"

  # Export the required Environment variables
  export DEVICE_JS="DirectDevice-JS" DEVICE_NET="DirectDevice-NET"
  export DEVICE_JS_CONNECTION=$(az iot hub device-identity show-connection-string --hub-name $Hub --device-id $DEVICE_JS -otsv)

  # Execute the Docker Container
  MESSAGE_INTERVAL=10 docker run -it localhost:5000/iot-control-js:latest
  ```
