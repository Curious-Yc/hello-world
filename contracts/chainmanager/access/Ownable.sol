// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

contract Ownable {
  
  //Event to show ownership has been transferred
  event OwnershipTransferred(address previousOwner, address newOwner);
  address private _owner;

  modifier onlyOwner() {
    require(msg.sender == owner());
    _;
  }

  //The initialize sets the original owner of the contract to the sender account.
  function initialize() public {
    setOwner(msg.sender);
  }

  //Tells the address of the owner
  function owner() public view returns (address) {
    return _owner;
  }
  
  //Sets a new owner address
  function setOwner(address newOwner) internal {
    _owner = newOwner;
  }

  //Allows the current owner to transfer control of the contract to a newOwner.
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner(), newOwner);
    setOwner(newOwner);
  }
}
