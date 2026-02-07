// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {IDiamondLoupe} from "../interfaces/diamond/IDiamondLoupe.sol";
import {LibDiamond} from "../libraries/LibDiamond.sol";

contract DiamondLoupeFacet is IDiamondLoupe {
    function facets() external view override returns (Facet[] memory facets_) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        uint256 numFacets = ds.facetAddresses.length;

        facets_ = new Facet[](numFacets);

        for (uint256 i; i < numFacets; i++) {
            address facetAddr = ds.facetAddresses[i];
            facets_[i].facetAddress = facetAddr;
            facets_[i].functionSelectors =
                ds.facetFunctionSelectors[facetAddr].functionSelectors;
        }
    }

    function facetFunctionSelectors(address _facet)
        external
        view
        override
        returns (bytes4[] memory)
    {
        return LibDiamond
            .diamondStorage()
            .facetFunctionSelectors[_facet]
            .functionSelectors;
    }

    function facetAddresses()
        external
        view
        override
        returns (address[] memory)
    {
        return LibDiamond.diamondStorage().facetAddresses;
    }

    function facetAddress(bytes4 _selector)
        external
        view
        override
        returns (address)
    {
        return LibDiamond
            .diamondStorage()
            .selectorToFacetAndPosition[_selector]
            .facetAddress;
    }
}
