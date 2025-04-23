// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./Survey.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SurveyFactory is Ownable {
    mapping(uint256 => address) private surveyAddresses;

    constructor() Ownable(msg.sender) {}

    function createSurvey(uint256 surveyID) public onlyOwner {
        require(surveyAddresses[surveyID] == address(0), "Survey with this ID already exists");
        Survey newSurvey = new Survey();
        surveyAddresses[surveyID] = address(newSurvey);
    }

    function getSurveyAddress(uint256 surveyID) public view returns (address) {
        return surveyAddresses[surveyID];
    }
}
