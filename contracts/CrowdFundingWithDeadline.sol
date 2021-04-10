// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

contract CrowdFundingWithDeadline {
    enum State {Ongoing, Failed, Succeeded, PaidOut}

    string public name;
    uint public targetAmount;
    uint public fundingDeadline;
    address public beneficiaryAddress;
    mapping(address => uint) public amounts;
    bool public collected;
    uint public totalCollected;

    State public state;

    modifier inState(State expectedState){
        require(state == expectedState, "invalid state");
        _;
    }

    event CampainFinished (
        address addr,
        uint totalCollect,
        bool succeeded
    );

    constructor(string memory contractName, uint  targetAmountInEth, uint  DurationInMin, address beneficiary)public{
        name = contractName;
        targetAmount= targetAmountInEth * 1 ether; //converts ether to wei
        fundingDeadline = currentTime() + DurationInMin * 1 minutes;
        beneficiaryAddress = beneficiary;
        state = State.Ongoing;
    }

    function contribute () public payable inState(State.Ongoing){
        require(beforeDeadline());
        
        amounts[msg.sender] += msg.value;
        totalCollected += msg.value;

        if(totalCollected >= targetAmount){
            collected = true;
        }

    }

    function collect() public inState(State.Succeeded){
        if(beneficiaryAddress.send(totalCollected)){
            state = State.PaidOut;
        }else{
            state = State.Failed;
        }
    }

    function withdraw() public  inState(State.Failed){
        require(amounts[msg.sender] > 0, "Nothing was contributed");
        uint contributed = amounts[msg.sender];
        amounts[msg.sender] = 0;

        if(!msg.sender.send(contributed)){
            amounts[msg.sender] = contributed;
        }
    }

    function finishCrowdFunding() public inState(State.Ongoing){
        require (!beforeDeadline());
        if(collected){
            state = State.Failed;
        }else {
            state = State.Succeeded;
        }

        emit CampainFinished(this, totalCollected, collected);
    }

    function beforeDeadline() internal view returns(bool){
        return currentTime() < fundingDeadline;
    }

    function currentTime() internal view  returns(uint){
        return block.timestamp;
    }
}