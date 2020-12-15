// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

import "./Ownable.sol";

contract Admin is Ownable {  
    
    //Administrator structure
    struct AdminObject {
      string name;
      uint time;
      bool able; 
      bool isUsed; 
    }
    
    mapping(address => AdminObject) internal admin; //Mapping of administrator address to structure
    uint internal adminAmount; //Number of administrators
    
    modifier isadmin() {
        require(admin[msg.sender].able == true, "admin is not grantor");
        _;
    }
    
    //Add manager
    function add_admin(address _addr,string memory _name) public onlyOwner {
        require(admin[_addr].isUsed == false,"admin exited!");
        admin[_addr] = AdminObject({
            name:_name,
            time:block.timestamp,
            able:true,
            isUsed:true
        });
        adminAmount++;
    } 
    
    //Remove manager rights
    function remove_admin(address _addr) public onlyOwner {
        require(admin[_addr].isUsed == true,"admin not exited!");
        admin[_addr].able = false;
        adminAmount--;
    }
}