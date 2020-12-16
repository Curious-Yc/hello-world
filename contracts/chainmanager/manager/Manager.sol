// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

import "./StorageData.sol";

/*
企业申请骨干链流程合约

管理员管理
1.管理员由本合约创建者管理
2.管理员和合约创建者能查询所有链在合约内的信息，申请企业只能查看自己链在合约内的信息
3.考虑添加合约创建者的继承者，以应对创建者密钥丢失

骨干链申请管理
1.企业发起申请骨干链请求
2.业务平台审核，通过合约中的方法同意/拒绝，同意后分配得到chiancode和chainid;
3.管理员和合约创建者有权力添加/删除/停用链
4.申请企业能停用自己的链
*/ 
contract Manager is StorageStructure {
    event issueProposal(address issuer);

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

    event addBlockHeaderInfo(address issuer,address chain_address);
    event removeBlockHeaderInfo(address issuer,uint blockheader_number);
    event updateBlockHeaderInfo(address issuer,uint blockheader_number);
  


    function issue_proposal(address _issuer,uint _time) public {
        Proposal memory _proposal;
        _proposal=Proposal({
            issuer_person:_issuer,
            issuer_time:_time,
            proccessed_time:uint(0),
            status:0
        });
        Proposals.push(_proposal);
        emit issueProposal(msg.sender);
        proposalAmount++;
    }

    function proccess_proposal(uint _num) public returns(string memory chain_code,uint chain_id){
        require(Proposals[_num].status == uint8(proposalState.unproccessed), "issuer resloved!");
        Proposals[_num].status=1;
        Proposals[_num].proccessed_time=block.timestamp;
        //chain_code,chain_id 如何产生；
        return (chain_code, chain_id);

    }

    // 对子链信息的操作
    function add_chain_info(address chain_addr,string memory _code,uint _id,string memory _name,address owner_addr) public  {
        chainInfo[chain_addr]=ChainObject({
            chain_code:_code,
            chain_id:_id,
            name:_name,
            chain_owner:owner_addr,
            time:block.timestamp
        });
        emit addChainInfo(msg.sender,chain_addr);
        chainAmount++;
    }
  
    function remove_chain_info(address chain_addr) public {
       delete chainInfo[chain_addr];
       emit removeChainInfo(msg.sender,chain_addr);
       chainAmount--;
    }
    
    function update_chain_info(address chain_addr,string memory _code,uint _id,string memory _name,address owner_addr) public  {
        chainInfo[chain_addr]=ChainObject({
            chain_code:_code,
            chain_id:_id,
            name:_name,
            chain_owner:owner_addr,
            time:block.timestamp
        });
        emit updateChainInfo(msg.sender,chain_addr);
    }    

    function get_chain_info(address chain_addr) view public returns(string memory,uint,string memory,address,uint) {
        return (chainInfo[chain_addr].chain_code,chainInfo[chain_addr].chain_id,chainInfo[chain_addr].name,chainInfo[chain_addr].chain_owner,chainInfo[chain_addr].time);
    }
    
    //对用户信息的操作
    function add_chain_user(address user_addr,string memory _name,string memory _email,string memory _region,string memory _mobile) public {
        userInfo[user_addr]=UserObject({
            name:_name,
            email:_email,
            region:_region,
            mobile:_mobile
        });
        emit addUserInfo(msg.sender,user_addr);
        userAmount++;
    }

    function remove_cahin_user (address user_addr) public {
        delete userInfo[user_addr];
        emit removeUserInfo(msg.sender,user_addr);
        userAmount--;
    }
    
    function update_chain_user(address user_addr,string memory _name,string memory _email,string memory _region,string memory _mobile)public{
        userInfo[user_addr]=UserObject({
            name:_name,
            email:_email,
            region:_region,
            mobile:_mobile
        });
        emit updateUserInfo(msg.sender,user_addr);
    }

    function get_chain_user(address user_addr) view public returns(string memory,string memory,string memory,string memory){
        return (userInfo[user_addr].name,userInfo[user_addr].email,userInfo[user_addr].region,userInfo[user_addr].mobile);
    }
    
    //对合约的操作
    function add_chain_contract(address contract_addr,string memory _name,string memory _type,address _ownerAddr,uint _time,bytes memory _byteCode,
    string memory _abi,bytes memory _hash) public {
        contractInfo[contract_addr]=ContractObject({
            name:_name,
            contract_type:_type,
            owner_address:_ownerAddr,
            contract_time:_time,
            byte_code:_byteCode,
            abi:_abi,
            contract_hash:_hash
        });
        emit addContractInfo(msg.sender,contract_addr);
        contractAmount++;
    }

    function remove_chain_contract(address contract_addr) public {
        delete contractInfo[contract_addr];
        emit removeContractInfo(msg.sender,contract_addr);
        contractAmount--;
    }

    function update_chain_contract(address contract_addr,string memory _name,string memory _type,address _ownerAddr,uint _time,
    bytes memory _byteCode,string memory _abi,bytes memory _hash) public {
        contractInfo[contract_addr]=ContractObject({
            name:_name,
            contract_type:_type,
            owner_address:_ownerAddr,
            contract_time:_time,
            byte_code:_byteCode,
            abi:_abi,
            contract_hash:_hash
        });
        emit updateContractInfo(msg.sender,contract_addr);
    }

    function get_chain_contract(address contract_addr) public view returns(string memory,string memory,address,uint,bytes memory,string memory,bytes memory) {
        return (contractInfo[contract_addr].name,contractInfo[contract_addr].contract_type,contractInfo[contract_addr].owner_address,
        contractInfo[contract_addr].contract_time,contractInfo[contract_addr].byte_code,contractInfo[contract_addr].abi,contractInfo[contract_addr].contract_hash);
    }
    
    //对节点的操作
    function add_chain_node(address node_addr,string memory _code,uint _id,string memory _name,string memory _version,string memory _algorithm) public {
        nodeInfo[node_addr]=NodeObject({
            chain_code: _code,
            chain_id:_id,
            name:_name,
            version:_version,
            algorithm:_algorithm
            // industry:_industry,
            // sort:_sort,
            // scence:_sence,
            // website:_website,
            // browse:_browse,
            // node_json:_nodeJson,
            // service_ip:_ip,
            // http_port:_port,
            // config_json:configJson,
            // log:_log,
            // time:block.timestamp
        });
        emit addNodeInfo(msg.sender,node_addr);
        nodeAmount++;
    }

    function remove_cahin_node(address node_addr) public{
        delete nodeInfo[node_addr];
        emit removeNodeInfo(msg.sender,node_addr);
        nodeAmount--;
    }

    function update_chain_node(address node_addr,string memory _code,uint _id,string memory _name,string memory _version,string memory _algorithm) public{
        nodeInfo[node_addr]=NodeObject({
            chain_code: _code,
            chain_id:_id,
            name:_name,
            version:_version,
            algorithm:_algorithm
            // industry:_industry,
            // sort:_sort,
            // scence:_sence,
            // website:_website,
            // browse:_browse,
            // node_json:_nodeJson,
            // service_ip:_ip,
            // http_port:_port,
            // config_json:configJson,
            // log:_log,
            // time:block.timestamp
        });
        emit updateNodeInfo(msg.sender,node_addr);
    }

    function get_chain_node(address node_addr) public view returns(string memory,uint,string memory,string memory,string memory) {
        return (nodeInfo[node_addr].chain_code,nodeInfo[node_addr].chain_id,nodeInfo[node_addr].name,nodeInfo[node_addr].version,nodeInfo[node_addr].algorithm);
    }
    
    //对区块头的操作
    function add_chain_blockheader(address _chainAddr,bytes memory _hash,uint  _transationNum,string memory _person,uint _time) public {
        BlockHeaderObject memory _BlockHeaderObject;
        _BlockHeaderObject=BlockHeaderObject({
            chain_address:_chainAddr,
            blockheader_hash:_hash,
            transaction_num:_transationNum,
            block_person:_person,
            block_time:_time
        });
        blockheaderInfo.push(_BlockHeaderObject);
        emit addBlockHeaderInfo(msg.sender,_chainAddr);
        blockHeaderAmount++;
    }
    
    function update_chain_blockheader(uint _num,address _chainAddr,bytes memory _hash,uint  _transationNum,string memory _person,uint _time) public {
        blockheaderInfo[_num].chain_address=_chainAddr;
        blockheaderInfo[_num].blockheader_hash=_hash;
        blockheaderInfo[_num].transaction_num=_transationNum;
        blockheaderInfo[_num].block_person=_person;
        blockheaderInfo[_num].block_time=_time;
        emit updateBlockHeaderInfo(msg.sender,_num);
    }
    function remove_chain_blockheader(uint _num) public {
        delete blockheaderInfo[_num];
        emit removeBlockHeaderInfo(msg.sender,_num);
        blockHeaderAmount--;
    }     

    function get_chain_blockheader(uint _num) public view returns(address,bytes memory,uint,string memory,uint) {
        return (blockheaderInfo[_num].chain_address,blockheaderInfo[_num].blockheader_hash,blockheaderInfo[_num].transaction_num,blockheaderInfo[_num].block_person,
        blockheaderInfo[_num].block_time);
    }
}