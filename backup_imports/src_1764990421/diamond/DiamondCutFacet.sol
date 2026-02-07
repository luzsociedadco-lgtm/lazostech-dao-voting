// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;


import "../interfaces/diamond/IDiamondCut.sol";

/// @notice Skeleton DiamondCutFacet - implements IDiamondCut interface
contract DiamondCutFacet is IDiamondCut {

    event DiamondCut(FacetCut[] _cut, address _init, bytes _calldata);

    function diamondCut(FacetCut[] calldata, address, bytes calldata) external override {
        revert("diamondCut: implement in Diamond");
    }
}
