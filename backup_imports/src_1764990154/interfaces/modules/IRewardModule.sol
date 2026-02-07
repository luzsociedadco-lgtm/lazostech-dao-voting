// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface IRewardModule {

    struct MaterialRecord {
        uint256 aluminium;
        uint256 plastic;
        uint256 glass;
        uint256 cardboard;
    }

    function setRecycleRate(bytes32 material, uint256 rate) external;

    function calculateRecycleReward(address user, MaterialRecord calldata record)
        external view returns (uint256);

    function mintReward(address user, MaterialRecord calldata record) external;
}
