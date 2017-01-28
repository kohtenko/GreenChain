const blockchain = require('./ethereum');
//aws iot
const deviceModule = require('aws-iot-device-sdk').device;

const device = deviceModule({
  keyPath: '.\\GreenHub.private.key',
  certPath: '.\\GreenHub.cert.pem',
  caPath: '.\\root-CA.crt',
  clientId: 'GreenHub_Home_1',
  region: 'us-west-2',
  protocol: 'mqtts',
  host: 'acskms2u0rq2c.iot.us-west-2.amazonaws.com',
});

const homeDevicesTopics = ['SolarPanels', 'WindTurbines'];
homeDevicesTopics.forEach((topic, i, array) => {
  device.subscribe(topic);	
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
  const body = JSON.parse(payload);
//  console.log(`Energy message from Topic: ${ topic }, Device: ${ body.device }, Energy: ${ body.energyGenerated }`);
  
  //save to ethereum contract
  blockchain.accumulateEnergy(body.device, parseInt(body.energyGenerated), (err, res) => {
  });
});