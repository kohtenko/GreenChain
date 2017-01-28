pragma solidity ^0.4.2;

contract GreenChain {

  /* Section for Green Market, Inc. authorized specialist */
  mapping (bytes32 => address) deviceToUser;
  mapping (address => bytes32[]) userDevices;
  
  mapping (bytes32 => uint[]) accumulatedEnergyByDevice;
  mapping (bytes32 => uint[]) consumedEnergyByDevice;
  
  function addDevice(bytes32 device, address user) {
      //TBD: msg.sender == Authorized Specialist (static accounts)
      deviceToUser[device] = user;
      userDevices[user].push(device);
  }
  
  function removeDevices(address user) {
      //TBD: msg.sender == Authorized Specialist (static accounts)
      for (uint i = 0; i < userDevices[user].length; i++) {
         deviceToUser[userDevices[user][i]] = 0x0000000000000000000000000000000000000000;
      }
      userDevices[user] = new bytes32[](0);
  }
  
  function getUserDevices(address user) constant returns (bytes32[] devices) {
      return userDevices[user];
  }
  
  function getUserByDevice(bytes32 device) constant returns (address user) {
      return deviceToUser[device];
  }
  
  /* Section for user and devices */
  
  function accumulateEnergy(bytes32 device, uint energyDelta) {
      address realUser = deviceToUser[device];
      if (msg.sender == realUser) {
          accumulatedEnergyByDevice[device].push(energyDelta);   
      }
  }
  
  function getDeviceAccumulatedEnergy(bytes32 device) constant returns (uint[] energy) {
      return accumulatedEnergyByDevice[device];
  }
  
  function consumeEnergy(bytes32 device, uint energyDelta) {
      address realUser = deviceToUser[device];
      if (msg.sender == realUser) {
          consumedEnergyByDevice[device].push(energyDelta);   
      }
  }
  
  function getDeviceConsumedEnergy(bytes32 device) constant returns (uint[] energy) {
      return consumedEnergyByDevice[device];
  }
  
  function getGreenEnergy(address user) constant returns (int balance) {
      int sum = 0;
      for (uint i = 0; i < userDevices[user].length; i++) {
         bytes32 device = userDevices[user][i];
         for (uint j = 0; j < accumulatedEnergyByDevice[device].length; j++) {
             sum += int(accumulatedEnergyByDevice[device][i]);  
         }
      }
      return sum;
  }
  
  /* Section for Market information and operations */
  
  function getGreenBalance(address user) constant returns (int balance) {
      int sum = getGreenEnergy(user);
      int k = 3; //TBD use oraclize to get actual price information
      return sum / k;
  }
  
}