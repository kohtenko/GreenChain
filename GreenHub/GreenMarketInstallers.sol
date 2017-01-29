pragma solidity ^0.4.2;

contract EntitlementRegistry{function get(string _name)constant returns(address);function getOrThrow(string _name)constant returns(address);}
contract Entitlement{function isEntitled(address _address)constant returns(bool);}

contract GreenMarketInstallers {

  // BlockOne ID bindings

  // The address below is for the norsborg network only
  EntitlementRegistry entitlementRegistry = EntitlementRegistry(0x995bef79dfa2e666de2c6e5f751b4483b6d05cd8);

  function getEntitlement() constant returns(address) {
      return entitlementRegistry.getOrThrow("com.da.gc");
  }

  modifier entitledUsersOnly {
    if (!Entitlement(getEntitlement()).isEntitled(msg.sender)) throw;
    _;
  }

  // Only authorized specialists (installers) can link installed (at home) device with user
  function authorizedInstallDevice(bytes32 device, address user) entitledUsersOnly {
      // The address below is for the norsborg network only
      GreenChain gc = GreenChain(0x977ddf44438d540892d1b8618fea653953999716);
      gc.addDevice(device, user);
  }
  
  // Only authorized specialists (installers) can link installed (at home) device with user
  function authorizedRemoveDevice(address user) entitledUsersOnly {
      // The address below is for the norsborg network only
      GreenChain gc = GreenChain(0x977ddf44438d540892d1b8618fea653953999716);
      gc.removeDevices(user);
  }

}

contract GreenChain {

  function addDevice(bytes32 device, address user) {
      //TBD: msg.sender == Authorized Specialist (static accounts)
  }
  
  function removeDevices(address user) {
      //TBD: msg.sender == Authorized Specialist (static accounts)
  }
}