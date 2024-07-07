// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DistributorRegistry {
    struct Distributor {
        string name;
        string details;
        uint256 distributorID;
        address distributorAddress;
        uint256 registrationDate;
        uint256 blockNumber;
    }

    mapping(uint256 => Distributor) public distributors;
    uint256 public totalDistributors;

    event DistributorAdded(uint256 indexed id, string name, string details, uint256 distributorID, address indexed distributorAddress, uint256 registrationDate, uint256 blockNumber);
    event DistributorDeleted(uint256 indexed id);

    function addDistributor(string memory _name, string memory _details, uint256 _distributorID, address _distributorAddress, uint256 _registrationDate) external {
        totalDistributors++;
        distributors[totalDistributors] = Distributor(_name, _details, _distributorID, _distributorAddress, _registrationDate, block.number);
        emit DistributorAdded(totalDistributors, _name, _details, _distributorID, _distributorAddress, _registrationDate, block.number);
    }

    function deleteDistributor(uint256 _id) external {
        require(_id <= totalDistributors, "Distributor does not exist");
        require(msg.sender == distributors[_id].distributorAddress, "Only distributor can delete itself");
        
        delete distributors[_id];
        emit DistributorDeleted(_id);
    }
    
    function getAllDistributors() external view returns (Distributor[] memory) {
        Distributor[] memory allDistributors = new Distributor[](totalDistributors);
        for (uint256 i = 1; i <= totalDistributors; i++) {
            allDistributors[i - 1] = distributors[i];
        }
        return allDistributors;
    }
}
