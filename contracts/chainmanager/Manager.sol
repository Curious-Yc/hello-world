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
  // event IssueProposer(address issuer, address node_address);
  // event ProccessProposer(address issuer, address node_address);
  // event AddNode(address issuer, address node_address);
  // event RemoveNode(address issuer, address node_address);
  // event UpdateNodeInfo(address issuer, address node_address);
  // event UpdateNodeProfile(address issuer, address node_address);
    event addChainInfo(address issuer,address chain_address);
    event removeChainInfo(address issuer,address chain_address);
    event updateChainInfo(address issuer,address chain_address);

    event addUserInfo(address issuer,address user_address);
    event removeUserInfo(address issuer,address user_address);
    event updateUserInfo(address issuer,address user_address);

    event addContractInfo(address issuer,address contract_address);
    event removeContractInfo(address issuer,address contract_address);
    event updateContractInfo(address issuer,address contract_address);

    event addNodeInfo(address issuer,address node_address);
    event removeNodeInfo(address issuer,address node_address);
    event updateNodeInfo(address issuer,address node_address);

    event addBlockHeaderInfo(address issuer);
    event removeBlockHeaderInfo(address issuer,uint blockheader_number);
  


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
    
    // 对子链信息的操作
    function add_chain_info(address chain_addr,ChainObject memory _chainObject) public  {
        chainInfo[chain_addr]=_chainObject;
        emit addChainInfo(msg.sender,chain_addr);
        chainAmount++;
    }
  
    function remove_chain_info(address chain_addr) public {
       delete chainInfo[chain_addr];
       emit removeChainInfo(msg.sender,chain_addr);
       chainAmount--;
    }
    
    function update_chain_info(address chain_addr,ChainObject memory _chainObject) public  {
        chainInfo[chain_addr]=_chainObject;
        emit updateChainInfo(msg.sender,chain_addr);
    }    

    function get_chain_info(address addr) view public returns(ChainObject memory) {
        return chainInfo[addr];
    }
    
    //对用户信息的操作
    function add_chain_user(address user_addr,UserObject memory _userObject) public {
        userInfo[user_addr]=_userObject;
        emit addUserInfo(msg.sender,user_addr);
        userAmount++;
    }

    function remove_cahin_user (address user_addr) public {
        delete userInfo[user_addr];
        emit removeUserInfo(msg.sender,user_addr);
        userAmount--;
    }
    
    function update_chain_user(address user_addr,UserObject memory _userObject)public{
        userInfo[user_addr]=_userObject;
        emit updateUserInfo(msg.sender,user_addr);
    }

    function get_chain_user(address user_addr) view public returns( UserObject memory){
        return userInfo[user_addr];
    }
    
    //对合约的操作
    function add_chain_contract(address contract_addr,ContractObject memory _contractObject) public {
        contractInfo[contract_addr]=_contractObject;
        emit addContractInfo(msg.sender,contract_addr);
        contractAmount++;
    }

    function remove_chain_contract(address contract_addr) public {
        delete contractInfo[contract_addr];
        emit removeContractInfo(msg.sender,contract_addr);
        contractAmount--;
    }

    function update_chain_contract(address contract_addr,ContractObject memory _contractObject) public {
        contractInfo[contract_addr]=_contractObject;
        emit updateContractInfo(msg.sender,contract_addr);
    }

    function get_chain_contract(address contract_addr) public returns(ContractObject memory) {
        return contractInfo[contract_addr];
    }
    
    //对节点的操作
    function add_chain_node(address node_addr,NodeObject memory _nodeObject) public {
        nodeInfo[node_addr]=_nodeObject;
        emit addNodeInfo(msg.sender,node_addr);
        nodeAmount++;
    }

    function remove_cahin_node(address node_addr) public{
        delete nodeInfo[node_addr];
        emit removeNodeInfo(msg.sender,node_addr);
        nodeAmount--;
    }

    function update_chain_node(address node_addr,NodeObject memory _nodeObject) public{
        nodeInfo[node_addr]=_nodeObject;
        emit updateNodeInfo(msg.sender,node_addr);
    }

    function get_chain_node(address node_addr) public returns(NodeObject memory) {
        return nodeInfo[node_addr];
    }
    
    //对区块头的操作
    function add_chain_blockheader(BlockHeaderObject memory _blockHeaderObject) public {
        blockheaderInfo.push(_blockHeaderObject);
        emit addBlockHeaderInfo(msg.sender);
        blockHeaderAmount++;
    }

    function remove_chain_blockheader(uint _num) public {
        delete blockheaderInfo[_num];
        emit removeBlockHeaderInfo(msg.sender,_num);
        blockHeaderAmount--;
    }     

    function get_chain_blockheader(uint _num) public returns(BlockHeaderObject memory) {
        return blockheaderInfo[_num];
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