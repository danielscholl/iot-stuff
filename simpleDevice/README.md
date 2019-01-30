# Simple Device

## Docker

1. Build the Container(s)

  `docker-compose build`

2. Run the Container(s)

  ```bash
    # Export the required Environment variables
    export Hub="cli-hub" DEVICE="DirectDevice"
    export DEVICE_CONNECTION_STRING=$(az iot hub device-identity show-connection-string --hub-name $Hub --device-id $DEVICE -otsv)

    # Build the Docker Containers
    docker-compose build

    # Run the Docker Containers
    docker-compose up
  ```
