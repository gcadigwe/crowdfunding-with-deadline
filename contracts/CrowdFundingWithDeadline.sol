// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract CrowdFundingWithDeadline {
    enum State {Ongoing, Failed, Succeeded, PaidOut}

    string public name;
    uint public targetAmount;
    uint public fundingDeadline;
    address public beneficiaryAddress;

    State public state;

    constructor(string memory contractName, uint  targetAmountInEth, uint  DurationInMin, address  beneficiary)public{
        name = contractName;
        targetAmount= targetAmountInEth * 1 ether; //converts ether to wei
        fundingDeadline = currentTime() + DurationInMin * 1 minutes;
        beneficiaryAddress = beneficiary;
        state = State.Ongoing;
    }

    function currentTime() internal view returns(uint){
        return block.timestamp;
    }
}