// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Ownable {

  event OwnershipTransferred(address previousOwner, address newOwner);
  address private _owner;

  modifier onlyOwner() {
    require(msg.sender == owner());
    _;
  }

  function initialize() public {
    setOwner(msg.sender);
  }

  function owner() public view returns (address) {
    return _owner;
  }

  function setOwner(address newOwner) internal {
    _owner = newOwner;
  }

  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner(), newOwner);
    setOwner(newOwner);
  }
}
