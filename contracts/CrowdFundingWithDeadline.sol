// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract CrowdFunding {
    enum State {Ongoing, Failed, Succeeded, PaidOut}

    string public name;
    uint public targetAmount;
    uint public fundingDeadline;
    address public beneficiaryAddress;

    State public state;

    constructor(string memory contractName, uint  targetAmountInEth, uint  DurationInMin, address  beneficiary){
        name = contractName;
        targetAmount= targetAmountInEth * 1 ether; //converts ether to wei
        fundingDeadline = block.timestamp + DurationInMin * 1 minutes;
        beneficiaryAddress = beneficiary;
        state = State.Ongoing;
    }
}