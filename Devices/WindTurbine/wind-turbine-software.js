//aws iot device software
const deviceModule = require('aws-iot-device-sdk').device;

const device = deviceModule({
  keyPath : '.\\WindTurbine.private.key',
  certPath : '.\\WindTurbine.cert.pem',
  caPath : '.\\root-CA.crt',
  clientId : 'WindTurbine_01',
  region : 'us-west-2',
  protocol : 'mqtts',
  host : 'acskms2u0rq2c.iot.us-west-2.amazonaws.com',
});

const deviceTopic = 'WindTurbines';

device.subscribe(deviceTopic);

//emulate connection with hardware
const server = require('websocket').server, http = require('http');

const port = 1332;
const socket = new server({
  httpServer: http.createServer().listen(port)
});

let connection;

socket.on('request', (request) => {
  connection = request.accept(null, request.origin);

  connection.on('message', (message) => {
    console.log('Wind Turbine has generated some energy: ' + message.utf8Data);
    device.publish(deviceTopic, JSON.stringify({
      device: 'WindTurbine_01',
      energyGenerated: message.utf8Data
    }));
  });

  connection.on('close', (connection) => {
    console.log('Wind Turbine is disconnected.');
  });  
});

device.on('connect', () => {
  console.log('connect');
});
device.on('close', () => {
  console.log('close');
});
device.on('reconnect', () => {
  console.log('reconnect');
});
device.on('offline', () => {
  console.log('offline');
});
device.on('error', (error) => {
  console.log('error', error);
});
device.on('message', (topic, payload) => {
  console.log('message', topic, payload.toString());
});
