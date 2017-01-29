var express = require('express');
var router = express.Router();
var path = require('path');
const blockchain = require('../ethereum');

const homeDevice1 = 'SolarPanel_01';
const homeDevice2 = 'WindTurbine_01';

router.get('/install', function(req, res) {

   blockchain.getUserByDevice(homeDevice1, (err, result) => {
     if (result === '0x0000000000000000000000000000000000000000') {
       blockchain.addDevice(homeDevice1, blockchain.user, (err, result) => {
         console.log(`Request to add ${ homeDevice1 }: ` + err + result); 
       });
     }
   });

   blockchain.getUserByDevice(homeDevice2, (err, result) => {
     if (result === '0x0000000000000000000000000000000000000000') {
       blockchain.addDevice(homeDevice2, blockchain.user, (err, result) => {
         console.log(`Request to add ${ homeDevice2 }: ` + err + result);
       });
     }
   });

   res.send('Installation is started.');
});

router.get('/remove', function(req, res) {

  blockchain.removeAll(blockchain.user, (err, result) => {
    console.log('Request to remove all for user: ' + err + result); 
  });

  res.send('Removing all.');
});

router.get('/authorized', function(req, res) {
  res.sendFile(path.join(__dirname + '/../public/html/green_market_authorized.html'));
});

module.exports = router;
