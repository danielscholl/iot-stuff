# SimpleControl - NodeJS

> The code base is driven off of environment variable settings.  A convenient way to set these is using [direnv](https://github.com/direnv/direnv) and then setting up the .envrc file.  _See the sample .envrc_sample_


__Build and Run the Code__

  ```bash
  Hub="cli-hub"
  export DEVICE="DirectDevice-JS"
  export MESSAGE_INTERVAL=5
  export HUB_CONNECTION_STRING="$(az iot hub show-connection-string --hub-name $Hub -otsv)"

  # Build and Run
  npm install
  npm start
  ```
