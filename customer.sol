// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ConsumerContract {
    // Event for generating block number
    event BlockNumberGenerated(uint256 blockNumber);

    // Function to generate block number based on medicine details
    function generateBlockNumber(string memory _name, string memory _details, string memory _dosage, uint256 _mfgDate, uint256 _expDate) external view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(_name, _details, _dosage, _mfgDate, _expDate)));
    }

    // Function to verify authenticity by comparing block numbers (optional)
    function verifyAuthenticity(uint256 _consumerBlockNumber, uint256 _manufacturerBlockNumber) external pure returns (bool) {
        return _consumerBlockNumber == _manufacturerBlockNumber;
    }
}
