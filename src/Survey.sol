// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Survey is Ownable {
    event RewardPaid(address indexed to, uint256 amount);
    event ContractFunded(address indexed from, uint256 amount);

    uint256 public rewardAmount;
    uint256 public rewardCount;
    mapping(address => uint256) public rewardRecipients;

    constructor(address _owner) Ownable(_owner) {}

    function fundContract() public payable {
        require(msg.value > 0, "Funding amount must be greater than 0");
        emit ContractFunded(msg.sender, msg.value);
    }

    function setReward(uint256 _rewardAmount) public onlyOwner {
        require(_rewardAmount > 0, "Reward amount must be greater than 0");
        rewardAmount = _rewardAmount;
    }

    function claimReward(address payable _to) public payable {
        require(rewardRecipients[_to] == 0, "Reward already claimed");
        require(rewardAmount > 0, "Reward amount not set");
        require(address(this).balance >= rewardAmount, "Insufficient contract balance");
        (bool sent, bytes memory data) = _to.call{value: rewardAmount}("");
        require(sent, "Failed to send Ether");
        rewardCount += 1;
        rewardRecipients[_to] = rewardAmount;
        emit RewardPaid(_to, rewardAmount);
    }
}
