// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {IDiamondCut} from "src/interfaces/diamond/IDiamondCut.sol";

library LibDiamond {
    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    bytes32 internal constant DIAMOND_STORAGE_POSITION = keccak256("diamond.standard.diamond.storage");

    struct FacetAddressAndPosition {
        address facetAddress;
        uint96 functionSelectorPosition;
    }

    struct FacetFunctionSelectors {
        bytes4[] functionSelectors;
        uint256 facetAddressPosition;
    }

    struct DiamondStorage {
        mapping(bytes4 => FacetAddressAndPosition) selectorToFacetAndPosition;
        mapping(address => FacetFunctionSelectors) facetFunctionSelectors;
        address[] facetAddresses;
        address contractOwner;
    }

    function diamondStorage() internal pure returns (DiamondStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

    /*//////////////////////////////////////////////////////////////
                                OWNERSHIP
    //////////////////////////////////////////////////////////////*/

    function contractOwner() internal view returns (address) {
        return diamondStorage().contractOwner;
    }

    function setContractOwner(address newOwner) internal {
        require(newOwner != address(0), "LibDiamond: zero owner");
        diamondStorage().contractOwner = newOwner;
    }

    function enforceIsContractOwner() internal view {
        require(msg.sender == diamondStorage().contractOwner, "LibDiamond: NOT_OWNER");
    }

    /*//////////////////////////////////////////////////////////////
                              DIAMOND CUT
    //////////////////////////////////////////////////////////////*/

    function diamondCut(IDiamondCut.FacetCut[] memory facetCuts, address init, bytes memory calldata_) internal {
        for (uint256 i; i < facetCuts.length; i++) {
            IDiamondCut.FacetCutAction action = facetCuts[i].action;

            if (action == IDiamondCut.FacetCutAction.Add) {
                _addFunctions(facetCuts[i].facetAddress, facetCuts[i].functionSelectors);
            } else if (action == IDiamondCut.FacetCutAction.Replace) {
                _replaceFunctions(facetCuts[i].facetAddress, facetCuts[i].functionSelectors);
            } else if (action == IDiamondCut.FacetCutAction.Remove) {
                _removeFunctions(facetCuts[i].facetAddress, facetCuts[i].functionSelectors);
            } else {
                revert("LibDiamond: invalid FacetCutAction");
            }
        }

        _initializeDiamondCut(init, calldata_);
    }

    /*//////////////////////////////////////////////////////////////
                         DIAMOND CUT HELPERS
    //////////////////////////////////////////////////////////////*/

    function _addFunctions(address facetAddress, bytes4[] memory selectors) private {
        require(facetAddress != address(0), "LibDiamond: add zero facet");

        DiamondStorage storage ds = diamondStorage();
        FacetFunctionSelectors storage ffs = ds.facetFunctionSelectors[facetAddress];

        if (ffs.functionSelectors.length == 0) {
            ffs.facetAddressPosition = ds.facetAddresses.length;
            ds.facetAddresses.push(facetAddress);
        }

        for (uint256 i; i < selectors.length; i++) {
            bytes4 selector = selectors[i];
            require(ds.selectorToFacetAndPosition[selector].facetAddress == address(0), "LibDiamond: selector exists");

            ds.selectorToFacetAndPosition[selector] = FacetAddressAndPosition({
                facetAddress: facetAddress, functionSelectorPosition: uint96(ffs.functionSelectors.length)
            });

            ffs.functionSelectors.push(selector);
        }
    }

    function _replaceFunctions(address facetAddress, bytes4[] memory selectors) private {
        require(facetAddress != address(0), "LibDiamond: replace zero facet");

        for (uint256 i; i < selectors.length; i++) {
            bytes4 selector = selectors[i];
            address oldFacet = diamondStorage().selectorToFacetAndPosition[selector].facetAddress;

            require(oldFacet != facetAddress, "LibDiamond: same facet");
            require(oldFacet != address(0), "LibDiamond: selector missing");

            _removeFunction(oldFacet, selector);
        }

        _addFunctions(facetAddress, selectors);
    }

    function _removeFunctions(address facetAddress, bytes4[] memory selectors) private {
        require(facetAddress == address(0), "LibDiamond: facet must be zero");

        for (uint256 i; i < selectors.length; i++) {
            bytes4 selector = selectors[i];
            address oldFacet = diamondStorage().selectorToFacetAndPosition[selector].facetAddress;

            _removeFunction(oldFacet, selector);
        }
    }

    function _removeFunction(address facetAddress, bytes4 selector) private {
        DiamondStorage storage ds = diamondStorage();
        FacetFunctionSelectors storage ffs = ds.facetFunctionSelectors[facetAddress];

        uint256 selectorPos = ds.selectorToFacetAndPosition[selector].functionSelectorPosition;

        uint256 lastPos = ffs.functionSelectors.length - 1;

        if (selectorPos != lastPos) {
            bytes4 lastSelector = ffs.functionSelectors[lastPos];
            ffs.functionSelectors[selectorPos] = lastSelector;
            ds.selectorToFacetAndPosition[lastSelector].functionSelectorPosition =
            // forge-lint: disable-next-line(unsafe-typecast)
            uint96(selectorPos);
        }

        ffs.functionSelectors.pop();
        delete ds.selectorToFacetAndPosition[selector];

        if (ffs.functionSelectors.length == 0) {
            uint256 lastFacetPos = ds.facetAddresses.length - 1;
            uint256 facetPos = ffs.facetAddressPosition;

            if (facetPos != lastFacetPos) {
                address lastFacet = ds.facetAddresses[lastFacetPos];
                ds.facetAddresses[facetPos] = lastFacet;
                ds.facetFunctionSelectors[lastFacet].facetAddressPosition = facetPos;
            }

            ds.facetAddresses.pop();
            delete ds.facetFunctionSelectors[facetAddress];
        }
    }

    function _initializeDiamondCut(address init, bytes memory calldata_) private {
        if (init == address(0)) {
            require(calldata_.length == 0, "LibDiamond: init calldata not empty");
            return;
        }

        (bool success, bytes memory err) = init.delegatecall(calldata_);
        require(success, err.length > 0 ? string(err) : "LibDiamond: init failed");
    }
}
