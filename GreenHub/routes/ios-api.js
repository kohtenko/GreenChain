var express = require('express');
var router = express.Router();
var path = require('path');
const blockchain = require('../ethereum');

const device_types = { 'SolarPanel_01': 'type1', 'WindTurbine_01': 'type2' };
const device_names = { 'SolarPanel_01': 'Home Roof Solar Panel (Philips)', 'WindTurbine_01': 'BackYard Wind Turbine (Siemens)' };

router.get('/user/devices', function(req, res) {
  blockchain.getUserDevices(blockchain.user, (err, result) => {
    if (result) {
      const d = [];
      result.forEach((elt, i, array) => {
        const id = blockchain.web3.toAscii(elt).replace(/\0/g, '');
        d.push({
          id: id,
          type: device_types[id],
          name: device_names[id]
        });
      });
      res.send({ devices: d });
    } else {
      res.send({ devices: [] });
    }
  });
});

router.get('/device/energy/:deviceId', function(req, res) {
  console.log('Get request for ' + req.params.deviceId);
  blockchain.getDeviceAccumulatedEnergy(req.params.deviceId, (err, result) => {
    if (result) {
      const en = [];
      let sum = 0;
      result.forEach((elt, i, array) => {
        en.push(parseInt(elt));
        sum += parseInt(elt);
      });
      console.log(en);
      res.send({ energy: en });
    }
  });
});

router.get('/user/green-balance', function(req, res) {
  blockchain.getGreenBalance(blockchain.user, (err, result) => {
    res.send({ balance: parseInt(result) });
  });
});

module.exports = router;
