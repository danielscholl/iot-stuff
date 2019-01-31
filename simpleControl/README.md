# SimpleControl

> The code base is driven off of environment variable settings.  A convenient way to set these is using [direnv](https://github.com/direnv/direnv) and then setting up the .envrc file.  _See the sample .envrc_sample_

__Build the Container(s)__

  ```bash
  docker-compose build
  ```

__Run the Container(s)__

  ```bash
  Hub="cli-hub" DEVICE_JS="DirectDevice-JS" DEVICE_NET="DirectDevice-NET"

  # Export the required Environment variables
  export DEVICE_JS="DirectDevice-JS" DEVICE_NET="DirectDevice-NET"
  export HUB_CONNECTION_STRING="$(az iot hub show-connection-string --hub-name $Hub -otsv)"

  # Build and Run the Docker Containers
  docker-compose up --build

  # Set the Desired Message Interval
  export MESSAGE_INTERVAL=6
  docker-compose up
  ```

