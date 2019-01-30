


```powershell
$Hub,$Device="cli-hub","DirectDevice"
$Env:DEVICE=$Device
$Env:DEVICE_CONNECTION_STRING="$(az iot hub device-identity show-connection-string --hub-name $Hub --device-id $Device -otsv)" 

docker build -t localhost:5000/iot-device-dotnet:latest .
docker run -it -e DEVICE_CONNECTION_STRING=$Env:DEVICE_CONNECTION_STRING -e DEVICE=$Env:DEVICE localhost:5000/iot-device-dotnet:latest
```
