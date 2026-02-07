// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





struct CampusMaterialRecord {
    address user;
    uint256 aluminium;
    uint256 plastic;
    uint256 cardboard;
    uint256 glass;
    uint256 timestamp;
}

interface IRecycleModule {
    event RecycleReported(address indexed user, uint256 aluminium, uint256 plastic, uint256 cardboard, uint256 glass);

    function reportRecycling(uint256 aluminium, uint256 plastic, uint256 cardboard, uint256 glass) external;
    function getHistory(address user) external view returns (CampusMaterialRecord[] memory);
}
