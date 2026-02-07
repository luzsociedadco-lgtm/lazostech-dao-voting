// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title IDiamondLoupe
 * @notice Interface for Diamond Loupe functions (EIP-2535)
 */
interface IDiamondLoupe {
    struct Facet {
        address facetAddress;
        bytes4[] functionSelectors;
    }

    function facets() external view returns (Facet[] memory facets_);

    function facetFunctionSelectors(address _facet)
        external
        view
        returns (bytes4[] memory selectors_);

    function facetAddresses()
        external
        view
        returns (address[] memory facetAddresses_);

    function facetAddress(bytes4 _selector)
        external
        view
        returns (address facetAddress_);
}
