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

module.exports = router;
