// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./Survey.sol";

contract SurveyFactory {
    mapping(uint256 => address) private surveyAddresses;
    address private surveyFactoryOwner;

    function createSurvey(uint256 surveyID) public {
        require(surveyFactoryOwner == msg.sender, "Only the owner can create surveys");
        require(surveyAddresses[surveyID] == address(0), "Survey with this ID already exists");
        Survey newSurvey = new Survey();
        surveyAddresses[surveyID] = address(newSurvey);
    }

    function getSurveyAddress(uint256 surveyID) public view returns (address) {
        return surveyAddresses[surveyID];
    }
}
