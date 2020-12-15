// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.8.0;
pragma experimental ABIEncoderV2;

contract Vote {
    //定义一个投票人结构体
    struct Voter{
        uint voteNumber; //给谁投票
        bool isVoted; //是否已经投过票
        uint weight; //投票权重
        address delegate; //指定给谁代理投票
    }

    //定义一个候选人结构体
    struct Candidate{
        string name; //候选人名字
        uint voteCount; //候选人得到的票数
    }

    address public admin;//管理者，负责给投票人授权，使之成为投票人

    Candidate[] public candidates;  //投票人集合
    mapping(address => Voter) public voters; //投票人集合

    constructor (string[] memory candidatesNames) public {
        admin=msg.sender;

        //每个人的名字生成一个候选人，添加到候选人集合中 ["aaa","bbb","ccc","ddd"]
        for (uint i=0;i<candidatesNames.length;i++){
            Candidate memory tmp = Candidate({name:candidatesNames[i],voteCount:0});
            candidates.push(tmp);
        }
    }

    //限定只有管理人才有添加投票人的权利
    modifier amdinOnly(){
        require(admin==msg.sender);
        _;
    }

    //添加投票人
    function giveVoteRight(address addr) amdinOnly public{
        if (voters[addr].weight>0||voters[addr].isVoted){
            revert();
        }
        voters[addr].weight=1;
    }

    //将投票权给代理人
    function findDelegate(address _delegate)public{
        Voter storage _voter=voters[msg.sender];

        if (_voter.weight<=0||_voter.isVoted){
            revert();
        }
        //轮询找到最终的代理人，并且代理人不能是自己，否则死循环；
        while(voters[_delegate].delegate!=address(0)&&voters[_delegate].delegate!=msg.sender){
            _delegate=voters[_delegate].delegate;
        }

        //代理如果是自己，退出；
        require(_delegate!=msg.sender);

        _voter.isVoted=true;
        _voter.delegate=_delegate;

        Voter storage finalDelegateVoter =voters[_delegate];
        if (finalDelegateVoter.isVoted){
            //如果代理人已经投过票，那么代理人投票的候选人票数加上自己的权重；
            candidates[finalDelegateVoter.voteNumber].voteCount+=_voter.weight;
        }else{
            //否则，在代理人权重上加上自己的权重；
            finalDelegateVoter.weight+=_voter.weight;
        }
    }
    //投票
    function vote(uint voteNum)public{
        Voter storage voter=voters[msg.sender];

        //不是候选人或者已经投过票，直接返回
        if (voter.weight<=0||voter.isVoted){
            revert();
        }

        voter.isVoted=true;
        voter.voteNumber=voteNum;

        candidates[voteNum].voteCount+=voter.weight;
    }
    
    //谁赢了
    // function whoWin()public view returns(string memory,uint){
    //     string memory winner;
    //     uint winerVoteCount;

    //     for (uint i=0;i<candidates.length;i++){
    //         if (candidates[i].voteCount>winerVoteCount){
    //           winner=candidates[i].name;
    //           winerVoteCount=candidates[i].voteCount;
    //         }
    //     }
    //   return (winner,winerVoteCount);
    // }
}