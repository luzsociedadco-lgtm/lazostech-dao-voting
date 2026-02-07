// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





/// @notice Minimal IDiamondCut interface (EIP-2535)
interface IDiamondCut {
    enum FacetCutAction { Add, Replace, Remove }
    struct FacetCut { address facetAddress; FacetCutAction action; bytes4[] functionSelectors; }

    /// @notice Add/replace/remove exising facets.
    function diamondCut(FacetCut[] calldata _cut, address _init, bytes calldata _calldata) external;
}
