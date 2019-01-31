# SimpleDevice - Dotnet

> The code base is driven off of environment variable settings.  A convenient way to set these is using [direnv](https://github.com/direnv/direnv) and then setting up the .envrc file.  _See the sample .envrc_sample_


__Build and Run the Code__

  ```powershell
  # If PowerShell
  $Hub="cli-hub"
  $Env:DEVICE="DirectDevice-NET"
  $Env:DEVICE_CONNECTION_STRING="$(az iot hub device-identity show-connection-string --hub-name $Hub --device-id $Env:DEVICE -otsv)" 

  # If Bash
  Hub="cli-hub"
  export DEVICE="DirectDevice-NET"
  export DEVICE_CONNECTION_STRING="$(az iot hub device-identity show-connection-string --hub-name $Hub --device-id $DEVICE -otsv)"

  # Build and Run
  dotnet build
  dotnet run
  ```
