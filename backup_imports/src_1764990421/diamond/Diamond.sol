// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





import "../interfaces/diamond/IDiamondCut.sol" as X;

/// @notice Minimal Diamond (dispatcher). Storage & dispatch logic must be implemented.
/// This file is intentionally minimal — treat as a placeholder to wire facets in tests/deploys.
contract Diamond {
    // Diamond fallback router
    fallback() external payable {
        // delegatecall to facet based on selector (implement in full version)
        revert("Diamond fallback: not implemented in skeleton");
    }

    receive() external payable {}
}
