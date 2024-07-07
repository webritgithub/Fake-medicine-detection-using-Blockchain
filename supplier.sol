// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplierRegistry {
    struct Supplier {
        string name;
        string details;
        uint256 supplierID;
        address supplierAddress;
        uint256 registrationDate;
        uint256 blockNumber;
    }

    mapping(uint256 => Supplier) public suppliers;
    uint256 public totalSuppliers;

    event SupplierAdded(uint256 indexed id, string name, string details, uint256 supplierID, address indexed supplierAddress, uint256 registrationDate, uint256 blockNumber);
    event SupplierDeleted(uint256 indexed id);

    function addSupplier(string memory _name, string memory _details, uint256 _supplierID, address _supplierAddress, uint256 _registrationDate) external {
        totalSuppliers++;
        suppliers[totalSuppliers] = Supplier(_name, _details, _supplierID, _supplierAddress, _registrationDate, block.number);
        emit SupplierAdded(totalSuppliers, _name, _details, _supplierID, _supplierAddress, _registrationDate, block.number);
    }

    function deleteSupplier(uint256 _id) external {
        require(_id <= totalSuppliers, "Supplier does not exist");
        require(msg.sender == suppliers[_id].supplierAddress, "Only supplier can delete itself");
        
        delete suppliers[_id];
        emit SupplierDeleted(_id);
    }
    
    function getAllSuppliers() external view returns (Supplier[] memory) {
        Supplier[] memory allSuppliers = new Supplier[](totalSuppliers);
        for (uint256 i = 1; i <= totalSuppliers; i++) {
            allSuppliers[i - 1] = suppliers[i];
        }
        return allSuppliers;
    }
}
