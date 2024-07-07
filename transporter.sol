// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransporterRegistry {
    struct Transporter {
        string name;
        string details;
        uint256 transporterID;
        address transporterAddress;
        uint256 registrationDate;
        uint256 blockNumber;
    }

    mapping(uint256 => Transporter) public transporters;
    uint256 public totalTransporters;

    function addTransporter(string memory _name, string memory _details, uint256 _transporterID, address _transporterAddress, uint256 _registrationDate) external {
        totalTransporters++;
        transporters[totalTransporters] = Transporter(_name, _details, _transporterID, _transporterAddress, _registrationDate, block.number);
    }

    function deleteTransporter(uint256 _id) external {
        require(_id <= totalTransporters, "Transporter does not exist");
        require(msg.sender == transporters[_id].transporterAddress, "Only transporter can delete itself");
        
        delete transporters[_id];
    }
    
    function getAllTransporters() external view returns (Transporter[] memory) {
        Transporter[] memory allTransporters = new Transporter[](totalTransporters);
        for (uint256 i = 1; i <= totalTransporters; i++) {
            allTransporters[i - 1] = transporters[i];
        }
        return allTransporters;
    }
}
