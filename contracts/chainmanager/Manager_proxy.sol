// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

/*
企业申请骨干链流程合约

管理员管理
1.管理员由本合约创建者管理
2.管理员和合约创建者能查询所有链在合约内的信息，申请企业只能查看自己链在合约内的信息
3.成为管理员需要发起申请，由本合约创建人或者本合约超级管理员中的任何一个审核(同意/删除/拒绝/暂时禁用，需附原因)
4.管理员可以发起申请成为超级管理员的请求，由本合约创建人审核(同意/删除/拒绝/暂时禁用，需附原因)
5.超级管理员可以管理普通管理员(同意/删除/拒绝/暂时禁用，需附原因)
6.是否考虑添加合约创建者的继承者，以应对创建者密钥丢失？？？

骨干链申请管理
1.企业发起申请骨干链请求
2.业务平台审核，通过合约中的方法同意/拒绝，同意后分配得到chiancode和chainid,并给申请地址转账1w bifer
3.管理员和合约创建者有权力添加/删除/停用链
4.申请企业能停用自己的链
*/
contract Proxy {
     bool internal _initialized;

    //确保只有所有者可以运行这个函数
    modifier onlyOwner() {
        require (msg.sender == owner);
        _;
    }

   //设置管理者owner地址
    function initialize() public {
        require(!_initialized);
        owner=msg.sender;
        _initialized = true;
    }

   //更新实现合约地址
    function upgradeTo(address _newImplementation) external onlyOwner {
        require(implementation != _newImplementation);
        _setImplementation(_newImplementation);
    }

   //回调
    function () payable public {
        address impl = implementation;
        require(impl != address(0));
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize)
            let result := delegatecall(gas, impl, ptr, calldatasize, 0, 0)
            let size := returndatasize
            returndatacopy(ptr, 0, size)

            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }

    //设置当前实现地址
    function _setImplementation(address _newImp) internal {
        implementation = _newImp;
    }
}

