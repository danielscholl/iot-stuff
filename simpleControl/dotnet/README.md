# SimpleControl - Dotnet

> Note: This project is targetting C# 7.3 and only runs on Windows at the moment.

```powershell
$Hub="cli-hub"
$Env:DEVICE="DirectDevice-NET"
$Env:MESSAGE_INTERVAL=5
$Env:HUB_CONNECTION_STRING="$(az iot hub  show-connection-string --hub-name $Hub -otsv)"


docker build -t localhost:5000/iot-control-dotnet:latest .
docker run -it -e HUB_CONNECTION_STRING=$Env:HUB_CONNECTION_STRING -e DEVICE=$Env:DEVICE -e MESSAGE_INTERVAL=$Env:MESSAGE_INTERVAL localhost:5000/iot-control-dotnet:latest
```
