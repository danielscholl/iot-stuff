const Device = require('./lib/device');
const Telemetry = require('./lib/models').Device;
const config = {
  connectionString: process.env.DEVICE_CONNECTION_STRING,
  interval: process.env.MESSAGE_INTERVAL || 1000
};

const device = new Device(config, Telemetry);
device.sendMessage(() => {
  process.exit(0);
});
