const contractAddress = '0x977ddf44438d540892d1b8618fea653953999716';
const contractAbi = [{"constant":true,"inputs":[{"name":"user","type":"address"}],"name":"getUserDevices","outputs":[{"name":"devices","type":"bytes32[]"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"user","type":"address"}],"name":"getGreenBalance","outputs":[{"name":"balance","type":"int256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"device","type":"bytes32"},{"name":"user","type":"address"}],"name":"addDevice","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"user","type":"address"}],"name":"removeDevices","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"user","type":"address"},{"name":"price","type":"uint256"},{"name":"good","type":"bytes32"}],"name":"buy","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"device","type":"bytes32"}],"name":"getUserByDevice","outputs":[{"name":"user","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"device","type":"bytes32"}],"name":"getDeviceConsumedEnergy","outputs":[{"name":"energy","type":"uint256[]"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"user","type":"address"}],"name":"getGreenEnergy","outputs":[{"name":"balance","type":"int256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"device","type":"bytes32"},{"name":"energyDelta","type":"uint256"}],"name":"consumeEnergy","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"device","type":"bytes32"},{"name":"energyDelta","type":"uint256"}],"name":"accumulateEnergy","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"device","type":"bytes32"}],"name":"getDeviceAccumulatedEnergy","outputs":[{"name":"energy","type":"uint256[]"}],"payable":false,"type":"function"}];

const Web3 = require('web3');
const web3 = new Web3();

const addr = 'http://localhost:8545';
web3.setProvider(new web3.providers.HttpProvider(addr));
web3.eth.defaultAccount = '0x0b5f3410d265fbdf41ec0be07a39b68005b51a0e';

const contract = web3.eth.contract(contractAbi).at(contractAddress);
console.log("Constract is ready: " + contract);

const one_user = "0x0b5f3410d265fbdf41ec0be07a39b68005b51a0e";

const api = {};
api.web3 = web3;
api.user = one_user; //full support for user management TBD

api.addDevice = function(device, user, done) {
  contract.addDevice.estimateGas(device, user, { from: one_user }, (err, gas) => {
    if (err) { return done(err); }
    gas += 20000;
    
    contract.addDevice.sendTransaction(device, user, { gas: gas, from: one_user }, (err, hash) => {
        if (err) { return done(err); }

        console.log('Method [addDevice] will be executed in ' + hash);
    });
  });
};

api.removeAll = function(user, done) {
  contract.removeDevices.estimateGas(user, { from: one_user }, (err, gas) => {
    if (err) { return done(err); }
    gas += 20000;
    
    contract.removeDevices.sendTransaction(user, { gas: gas, from: one_user }, (err, hash) => {
        if (err) { return done(err); }

        console.log('Method [removeDevices] will be executed in ' + hash);
    });
  });
};

api.getUserDevices = function(user, done) {
  contract.getUserDevices(user, (err, res) => {
    done(err, res);
  });
};

api.getUserByDevice = function(device, done) {
  contract.getUserByDevice(device, (err, res) => {
    done(err, res);
  });
};

api.accumulateEnergy = function(device, delta, done) {
  delta = parseInt(delta);
  contract.accumulateEnergy.estimateGas(device, delta, { from: one_user }, (err, gas) => {
    if (err) { return done(err); }
    console.log('Gas estimated for [accumulateEnergy] ' + gas);
    gas = 90000; //default

    contract.accumulateEnergy.sendTransaction(device, delta, { gas: gas, from: one_user }, (err, hash) => {
      if (err) {
        console.log('Method [accumulateEnergy] error: ' + err);
        return done(err); 
      }

      console.log(`Method [accumulateEnergy] with data: ${ device } -> ${ delta } will be executed in ${ hash }`);
    });
  });
};

api.getDeviceAccumulatedEnergy = function(device, done) {
  contract.getDeviceAccumulatedEnergy(device, (err, res) => {
    console.log('Method [getDeviceAccumulatedEnergy] returned: ' + err + res);
    done(err, res);
  });
};

api.getGreenBalance = function(user, done) {
  contract.getGreenBalance(user, (err, res) => {
    done(err, res);
  });
};

api.buy = function(user, price, good, done) {
  price = parseInt(price);
  contract.buy.estimateGas(user, price, good, { from: one_user }, (err, gas) => {
    if (err) { return done(err); }
    console.log('Gas estimated for [buy] ' + gas);

    contract.buy.sendTransaction(user, price, good, { gas: gas, from: one_user }, (err, hash) => {
      if (err) {
        console.log('Method [buy] error: ' + err);
        return done(err); 
      }

      console.log(`Method [buy] with data: ${ good } -> ${ price } will be executed in ${ hash }`);
    });
  });
};

module.exports = api;
