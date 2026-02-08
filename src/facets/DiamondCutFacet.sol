// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {IDiamondCut} from "../interfaces/diamond/IDiamondCut.sol";
import {LibDiamond} from "../libraries/LibDiamond.sol";

/// @notice DiamondCutFacet - Delegates to LibDiamond for updates
contract DiamondCutFacet is IDiamondCut {
    function diamondCut(FacetCut[] calldata _cut, address _init, bytes calldata _calldata) external override {
        LibDiamond.enforceIsContractOwner();
        LibDiamond.diamondCut(_cut, _init, _calldata);
    }
}
