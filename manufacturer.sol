// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicineRegistry {
    struct Medicine {
        string name;
        string details;
        uint256 medicineID;
        address manufacturer;
        uint256 blockNumber;
        string factoryName;
        string dosage;
        uint256 mfgDate;
        uint256 expDate;
    }    

    mapping(uint256 => Medicine) public medicines;
    uint256 public totalMedicines;

    event MedicineAdded(uint256 indexed id, string name, string details, uint256 medicineID, address indexed manufacturer, uint256 blockNumber, string factoryName, string dosage, uint256 mfgDate, uint256 expDate);
    event MedicineDeleted(uint256 indexed id);

    function addMedicine(string memory _name, string memory _details, uint256 _medicineID, string memory _factoryName, string memory _dosage, uint256 _mfgDate, uint256 _expDate) external {
        totalMedicines++;
        medicines[totalMedicines] = Medicine(_name, _details, _medicineID, msg.sender, block.number, _factoryName, _dosage, _mfgDate, _expDate);
        emit MedicineAdded(totalMedicines, _name, _details, _medicineID, msg.sender, block.number, _factoryName, _dosage, _mfgDate, _expDate);
    }

    function deleteMedicine(uint256 _id) external {
        require(_id <= totalMedicines, "Medicine does not exist");
        require(msg.sender == medicines[_id].manufacturer, "Only manufacturer can delete the medicine");
        
        delete medicines[_id];
        emit MedicineDeleted(_id);
    }
    
    function getAllMedicines() external view returns (Medicine[] memory) {
        Medicine[] memory allMedicines = new Medicine[](totalMedicines);
        for (uint256 i = 1; i <= totalMedicines; i++) {
            allMedicines[i - 1] = medicines[i];
        }
        return allMedicines;
    }
}
