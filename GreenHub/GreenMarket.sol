pragma solidity ^0.4.2;

contract GreenChain {

  /* Section for Green Market, Inc. authorized specialist */
  mapping (bytes32 => address) deviceToUser;
  mapping (address => bytes32[]) userDevices;
  
  mapping (bytes32 => uint[]) accumulatedEnergyByDevice;
  
  function addDevice(bytes32 device, address user) {
      //TBD: msg.sender == Authorized Specialist (account)
      deviceToUser[device] = user;
      userDevices[user].push(device);
  }
  
  function removeDevices(address user) {
      //TBD: msg.sender == Authorized Specialist (account)
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
      accumulatedEnergyByDevice[device].push(energyDelta);
  }
  
  function getDeviceAccumulatedEnergy(bytes32 device) constant returns (uint[] energy) {
      return accumulatedEnergyByDevice[device];
  }
  
  /* Section for Market information and operations */
  
}