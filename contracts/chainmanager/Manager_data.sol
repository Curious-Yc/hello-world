// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

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
 //  uint256 node_count = 0;
 //  uint256 proposal_count = 0;
    
  // event IssueProposer(address issuer, address node_address);
  // event ProccessProposer(address issuer, address node_address);
  // event AddNode(address issuer, address node_address);
  // event RemoveNode(address issuer, address node_address);
  // event UpdateNodeInfo(address issuer, address node_address);
  // event UpdateNodeProfile(address issuer, address node_address);
  

    struct Proposal {
      address issuer;
      address node_address;
      uint require_amount;
      uint issuer_time; //filled by block.timestamp
      uint proccessed_time;
      string issuer_desc;
      string proccess_desc;
      uint8 status; // 0 unprocessed, 1 approved, 2 rejected
    }
     
    //子链信息；
    struct ChainObject {
      address chain_address;
      string chain_code;
      uint chain_id;
      string name;
      uint time;
    } 

    mapping(string => ChainObject) internal chainInfo;
    uint internal chainAmount;

    //用户信息；
    struct UserObject {
      string name;
      string bid;
      string email;
      string region;
      string mobile; 
    }

    mapping(string => UserObject) internal userInfo;
    uint internal userAmount;

    //合约信息；
    struct ContractObject {
      string name;
      address contract_address;
      string constract_type;
      string owner_bid; //合约创建人的bid;
      string contract_time;
      bytes byte_code; //合约字节码;
      string abi;
      bytes constract_hash; //上报hash;
      uint8 status;  //合约状态; 0 proccessing 1 enable, 2 disable 
      string constract_time; //上报时间;
    }

    mapping(address => ContractObject) internal contractInfo;
    uint internal contractAmount;

    //区块头信息；
    struct BlockHeaderObject {
      bytes header_hash; 
      uint transaction_num;
      uint block_time;
    }

    mapping(address => ContractObject) internal blockHeaderInfo;
    uint internal blockHeaderAmount;

    //节点信息
  
   //mapping(address => NodeInfo) public NodeInfos;
  //  mapping(address => NodeProfile) public NodeProfiles;
  //  mapping(address => Proposal) public Proposals;
}
