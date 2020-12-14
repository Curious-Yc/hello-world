// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

import "./access/Admin.sol";
import "./math/SafeMath.sol";
import "./Manager_data.sol";

/*
企业申请骨干链流程合约

管理员管理
1.管理员由本合约创建者管理
2.管理员和合约创建者能查询所有链在合约内的信息，申请企业只能查看自己链在合约内的信息
3.是否考虑添加合约创建者的继承者，以应对创建者密钥丢失？？？

骨干链申请管理
1.企业发起申请骨干链请求
2.业务平台审核，通过合约中的方法同意/拒绝，同意后分配得到chiancode和chainid;
3.管理员和合约创建者有权力添加/删除/停用链
4.申请企业能停用自己的链
*/ 
contract Logic is StorageStructure,Admin {

    function issue_proposer() public returns(string,uint){
        //user issuer proposer
        
        //emit IssueProposer(msg.sender, msg.sender); //second address is node address
    }
    

    function set_chain_proposer() public returns(string,uint){
        string chainCode;
        uint chainId;
        proccess_proposer();
        return (chainCode,chainId);
    }

    function add_chain_info(address addr,string code,uint id,string _name) public isadmin {
        require(chainInfo[addr].chain_owner == address(0), "Chain exist!");
        chainInfo[addr]=ChainObject({
            chain_owner:addr,
            chain_code:code,
            chain_id:id,
            name:_name,
            time:block.timestamp
        });
        chainAmount++;
    }
  
    function remove_chain_info(string chainCode) public isadmin {
      
       delete chainInfo[chainCode];
       chainAmount--;
    }
    
    function update_chain_info()public isadmin {

    }    

    function get_chain_info(address addr) view public returns(ChainObject){
        // require(chinInfo[addr].status == chainState.enable,"Chain disable!");
        // require(isadmin || msg.sender == chainInfo[addr].chain_owner, "Have no power to get!");
        return chainInfo[addr];
    }
    
    function add_chain_user(string _name,string _bid,string _email,string _region,string _mobile) public {
        // require(chainInfo[addr].chain_owner != address(0), "Chain not exist!");
        // require(chainInfo[addr].chain_owner == msg.sender, "Have no power to get!");
        userInfo[_bid]=UserObject({
            name:_name,
            bid:_bid,
            email:_email,
            region:_region,
            mobile:_mobile
        });
        userAmount++;
    }

    
    function remove_cahin_user () public {
        
    }
    
    function update_chain_user()public{

    }

    function get_chain_user(address addr) view public returns(UserObject){
        return userInfo[addr];
    }

    function add_chain_contract(string _name,address addr,string _type,string bid,bytes byteCode,string _abi,bytes _hash) public {
        contractInfo[addr]=ContractObject({
            name:_name,
            contract_address:adrr,
            contract_type:_type,
            owner_bid:bid,
            contract_time:block.timestamp,
            byte_code:byteCode,
            abi:_abi,
            contract_hash:_hash,
            status:contractState.enable
        });
        contractAmount++;
    }

    function remove_chain_contract() public {

    }

    function update_chain_contract() public {

    }

    function get_chain_contract() public {
        
    }

    function add_chain_node() public {

    }

    function remove_cahin_node() public{

    }

    function update_chain_node() public{

    }

    function get_chain_node() public {

    }

    function add_chain_blockheader() public {

    }

    function remove_chain_blockheader() public {

    }     

    function update_chain_blockheader() public {

    }   

    function get_chain_blockheader() public {

    }

    function issue_proposer() public  {
        //user issuer proposer
        
        //emit IssueProposer(msg.sender, msg.sender); //second address is node address
    }
    
    function proccess_proposer() public  {
        //owner approve/reject proposer with each reason
        
        //emit ProccessProposer(msg.sender, msg.sender); //second address is node address
    }

}