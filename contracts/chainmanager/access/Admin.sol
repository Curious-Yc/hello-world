// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

import "./Ownable.sol";

contract Admin is Ownable {  
    
    struct AdminObject {
      address admin_address;
      string name;
      uint time;
      bool able;
    }

    mapping(address => AdminObject) internal admin;
    uint internal adminAmount;
    
    modifier isadmin() {
        require(admin[msg.sender].able == true, "admin is not grantor");
        _;
    }
    
    function add_admin(address addr,string memory _name) public onlyOwner {
        admin[addr] = AdminObject({
            admin_address:addr,
            name:_name,
            time:block.timestamp,
            able:true
        });
        adminAmount++;
    } 
    
    function remove_admin(address addr) public onlyOwner {
        admin[addr].able = false;
        adminAmount--;
    }
}