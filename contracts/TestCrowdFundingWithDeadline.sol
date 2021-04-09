// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./CrowdFundingWithDeadline.sol";

contract TestCrowdFundingWithDeadline is CrowdFundingWithDeadline {
    uint time;

    constructor(string memory contractName, uint targetAmount, uint fundingDeadline, address beneficiaryAddress) CrowdFundingWithDeadline(contractName, targetAmount, fundingDeadline, beneficiaryAddress) public {

    }

    function currentTime() public override returns(uint){
        return time;
    }

    function setCurrentTime(uint newTime) public {
        time = newTime;
    }
}