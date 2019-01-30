# Simple Control

## Docker

1. Build the Container(s)

  `docker build -t localhost:5000/iot-control-js:latest -f ./js/Dockerfile ./js`

2. Run the Container(s)

  ```bash
  # Export the required Environment variables
  export Hub="cli-hub"
  export DEVICE_JS="DirectDevice-JS" DEVICE_NET="DirectDevice-NET"
  export HUB_CONNECTION_STRING=$(az iot hub  show-connection-string --hub-name $Hub -otsv)

  # Build and Execute the Docker Container
  MESSAGE_INTERVAL=10 docker-compose up --build
  ```
