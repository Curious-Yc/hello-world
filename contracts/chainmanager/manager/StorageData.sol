// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

/*
企业申请骨干链流程合约

管理员管理
1.管理员由本合约创建者管理
2.管理员和合约创建者能查询所有链在合约内的信息，申请企业只能查看自己链在合约内的信息
3.成为管理员需要发起申请，由本合约创建人或者本合约超级管理员中的任何一个审核(同意/删除/拒绝/暂时禁用，需附原因)
4.是否考虑添加合约创建者的继承者，以应对创建者密钥丢失？？？

骨干链申请管理
1.企业发起申请骨干链请求
2.业务平台审核，通过合约中的方法同意/拒绝，同意后分配得到chiancode和chainid,并给申请地址转账1w bifer
3.管理员和合约创建者有权力添加/删除/停用链
4.申请企业能停用自己的链
*/
contract StorageStructure {
    
    enum proposalState {unproccessed,agree,reject}

    struct Proposal {
      address issuer_person;
      uint issuer_time; 
      uint proccessed_time;
      uint8 status;
      // string issuer_desc;
      // string proccess_desc;
    }

    Proposal[] Proposals;
    uint internal proposalAmount;
     
    //子链信息；
    struct ChainObject {
      string chain_code;
      uint chain_id;
      string name;
      address chain_owner;
      uint time;
    } 

    mapping(address => ChainObject) internal chainInfo;
    uint internal chainAmount;

    //用户信息；
    struct UserObject {
      string name;
      string email;
      string region;
      string mobile; 
    }

    mapping(address => UserObject) internal userInfo;
    uint internal userAmount;

    //合约信息；
    struct ContractObject {
      string name;
      string contract_type;
      address owner_address; 
      uint contract_time;
      bytes byte_code; 
      string abi;
      bytes contract_hash; 
    }

    mapping(address => ContractObject) internal contractInfo;
    uint internal contractAmount;

    //区块头信息；
    struct BlockHeaderObject {
      address chain_address;
      bytes blockheader_hash;
      uint transaction_num;
      string block_person;
      uint block_time;
    }
     
    BlockHeaderObject[] blockheaderInfo;
    uint internal blockHeaderAmount;

    //节点信息
    struct NodeObject {
      string chain_code;
      uint chain_id;
      string name;
      string version;
      string algorithm;
      //string industry;
      //string sort;
      //string scene;
      //string website;
      //string browse;
      //string node_json;
      //string service_ip;
      //uint http_port;
      //string config_json;
      //string log;
      //uint time;
    }

    mapping(address => NodeObject) internal nodeInfo;
    uint internal nodeAmount;
}
