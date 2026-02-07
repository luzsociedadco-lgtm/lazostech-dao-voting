// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





import "../interfaces/modules/IRecycleModule.sol" as X;

contract RecycleFacet is IRecycleModule {

    function reportRecycling(uint256 aluminium, uint256 plastic, uint256 cardboard, uint256 glass) external override {
        emit RecycleReported(msg.sender, aluminium, plastic, cardboard, glass);
    }

    function getHistory(address) external view override returns (CampusMaterialRecord[] memory) {
        revert("getHistory: implement");
    }
}
