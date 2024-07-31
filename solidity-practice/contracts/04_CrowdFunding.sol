// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CrowdFunding {
    address public immutable beneficiary;
    uint256 public immutable fundingGoal;
    uint256 public fundingAmount;
    mapping(address=>uint256) public funders;
    mapping(address=>bool) private fundersInserted;
    address[] public fundersKey;
    bool public AVAILABLED = true;
    constructor(address beneficiary_, uint256 goal_) {
        beneficiary = beneficiary_;
        fundingGoal = goal_;
    }
    function contribute() external payable {
        require(AVAILABLED, "CrowdFunding is closed");

        uint256 potentialFundingAmount = fundingAmount - fundingGoal;
        uint256 refundAmount = 0;

        if (potentialFundingAmount > fundingGoal) {
            refundAmount = potentialFundingAmount - fundingGoal;
            funders[msg.sender] += (msg.value - refundAmount);
            fundingAmount += (msg.value - refundAmount);
        } else {
            funders[msg.sender] += msg.value;
            fundingAmount += msg.value;
        }

        if (!fundersInserted[msg.sender]) {
            fundersInserted[msg.sender] = true;
            fundersKey.push(msg.sender);
        }

        if (refundAmount > 0) {
            payable(msg.sender).transfer(refundAmount);
        }
    }
    function close() external returns(bool) {
        if (fundingAmount < fundingGoal) {
            return false;
        }
        uint256 amount = fundingAmount;
        fundingAmount = 0;
        AVAILABLED = false;
        payable(beneficiary).transfer(amount);
        return true;
    }
    function fundersLenght() public view returns(uint256) {
        return fundersKey.length;
    }
}