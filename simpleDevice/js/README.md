# SimpleDevice - NodeJS

> The code base is driven off of environment variable settings.  A convenient way to set these is using [direnv](https://github.com/direnv/direnv) and then setting up the .envrc file.  _See the sample .envrc_sample_


__Manage a Device__
  
  ```bash
    npm run create:sas  # Create a Device using SAS Token
    npm run create:509  # Create a Device using x509 Certificate (Self Signed)

    npm run list        # Show Hub Devices
    npm run show        # Show Created Device
    npm run delete      # Delete Device

    npm run send        # Send Messages to Hub
    npm run monitor     # Monitor Messages for Device
  ```


__Build and Run the Code__

  ```bash
  Hub="cli-hub"
  export DEVICE="DirectDevice-JS"
  export DEVICE_CONNECTION=$(az iot hub device-identity show-connection-string --hub-name $Hub --device-id $DEVICE -otsv)
  export LOG_LEVEL="debug"

  # Build and Run
  npm install
  npm start
  ```
