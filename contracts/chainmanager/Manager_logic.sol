// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;
pragma experimental ABIEncoderV2;

import "./access/Admin.sol";
import "./lib/SafeMath.sol";
import "./StorageData.sol";

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

    function issue_proposer(address _issuer,address nodeAddr) public {
        //user issuer proposer
        Proposal memory _proposal;
        _proposal=Proposal({
            issuer:_issuer,
            node_address:nodeAddr,
            issuer_time:block.timestamp
            //issuer_desc:
            //proccess_desc:
            //status:
        });
        Proposals.push(_proposal);
        //emit IssueProposer(msg.sender, msg.sender); //second address is node address
    }

    // function process_proposer() public isadmin returns(string,uint){
        
    // }
    
    function set_chain_proposer() public returns(string memory,uint){
        string memory chainCode;
        uint chainId;
        proccess_proposer();
        return (chainCode,chainId);
    }

    function add_chain_info(address chain_addr,string memory code,uint id,string memory _name,address owner_addr) public isadmin {
        //require(chainInfo[addr].chain_owner == address(0), "Chain exist!");
        chainInfo[chain_addr]=ChainObject({
            chain_code:code,
            chain_id:id,
            name:_name,
            chain_owner:owner_addr,
            time:block.timestamp
        });
        chainAmount++;
    }
  
    function remove_chain_info(address addr) public isadmin {
       
       delete chainInfo[addr];
       chainAmount--;
    }
    
    function update_chain_info()public isadmin {
            
    }    

    function get_chain_info(address addr) view public returns(ChainObject memory){
        // require(chinInfo[addr].status == chainState.enable,"Chain disable!");
        // require(isadmin || msg.sender == chainInfo[addr].chain_owner, "Have no power to get!");
        return chainInfo[addr];
    }
    
    function add_chain_user(string memory _name,address _addr,string memory _email,string memory _region,string memory _mobile) public {
        // require(chainInfo[addr].chain_owner != address(0), "Chain not exist!");
        // require(chainInfo[addr].chain_owner == msg.sender, "Have no power to get!");
        userInfo[_addr]=UserObject({
            name:_name,
            email:_email,
            region:_region,
            mobile:_mobile
        });
        userAmount++;
    }

    
    function remove_cahin_user (address _addr) public {
        delete userInfo[_addr];
        userAmount--;
    }
    
    function update_chain_user()public{
        
    }

    function get_chain_user(address _addr) view public returns( UserObject memory){
        return userInfo[_addr];
    }

    function add_chain_contract(string memory _name,address _contractAddr,string memory _type,address ownerAddr,string memory _time,bytes memory byteCode,string memory _abi,bytes memory _hash) public {
        contractInfo[_contractAddr]=ContractObject({
            name:_name,
            contract_type:_type,
            owner_address:ownerAddr,
            contract_time:_time,
            byte_code:byteCode,
            abi:_abi,
            contract_hash:_hash
        });
        contractAmount++;
    }

    function remove_chain_contract(address _addr) public {
        delete contractInfo[_addr];
        contractAmount--;
    }

    function update_chain_contract() public {

    }

    function get_chain_contract(address _addr) public returns(ContractObject memory) {
        return contractInfo[_addr];
    }

    // function add_chain_node(address _addr,string memory _code,uint memory _id,string memory _name,string memory _version,string memory) public {
    //     nodeInfo[_addr]=NodeObject({
    //         chain_code: _code,
    //         chain_id:_id,
    //         name:_name,
    //         version:_verison,
    //         algorithm:_algorithm,
    //         industry:_industry,
    //         sort:_sort,
    //         scence:_sence,
    //         website:_website,
    //         browse:_browse,
    //         node_json:_nodeJson,
    //         service_ip:_ip,
    //         http_port:_port,
    //         config_json:configJson,
    //         log:_log,
    //         time:block.timestamp
    //     });
    //     nodeAmount--;
    // }

    function remove_cahin_node(address _addr) public{
        delete nodeInfo[_addr];
        nodeAmount--;
    }

    function update_chain_node() public{

    }

    function get_chain_node(address _addr) public returns(NodeObject memory) {
        return nodeInfo[_addr];
    }
    
    function add_chain_blockheader(address _addr,bytes memory _hash,uint  _num,string memory _person,string memory _time) public {
        //require(msg.sender );
        BlockHeaderObject memory _BlockHeaderObject;
        _BlockHeaderObject=BlockHeaderObject({
            chain_address:_addr,
            blockheader_hash:_hash,
            transaction_num:_num,
            block_person:_person,
            block_time:_time
        });
        blockheaderInfo.push(_BlockHeaderObject);
        blockHeaderAmount++;
    }

    // function remove_chain_blockheader(bytes _hash) public {
    //      delete blockheaderInfo[_hash];
    //      blockHeaderAmount--;
    // }     

    // function update_chain_blockheader() public {

    // }   

    function get_chain_blockheader(uint _number) public returns(BlockHeaderObject memory) {
         return blockheaderInfo[_number];
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