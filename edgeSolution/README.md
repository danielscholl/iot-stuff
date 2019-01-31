# EdgeSolution Custom Modules 

> The code base is driven off of environment variable settings.  A convenient way to set these is using [direnv](https://github.com/direnv/direnv) and then setting up the .envrc file.  _See the sample .envrc_sample_


## Getting Started with Development - Inner Loop 

This module code base should fully support InnerLoop Development using VSCode and the VSCode IoT Extension for deploying to EdgeSimulator

- Azure IoT Edge: Setup IoT Edge Simulator
- Azure IoT Edge: Build and Run IoT Edge Solution in Simulator
- Azure IoT Edge: Stop IoT Edge Simulator

## Getting Started with Development - Outer Loop


```bash
# Install the Required Environment File
npm install

# Build and Push the Modules to the Registry
npm run build

############                                            ############
### WARNING   Generate The IoT Edge Deployment Manifest  WARNING ###
############                                            ############

# Deploy the Modules to the edge
npm run deploy

# Remove the Modules from the edge
npm run clean
```
