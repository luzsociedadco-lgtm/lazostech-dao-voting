// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {UniversityFacet} from "../src/facets/UniversityFacet.sol";
import {IDiamondCut} from "../src/interfaces/diamond/IDiamondCut.sol";
import {DiamondCutFacet} from "../src/facets/DiamondCutFacet.sol";

contract DeployUniversity is Script {
    address constant DIAMOND = 0xF7A32c99401EdEFf07B86B4E0525da6a90664d3e;

    function run() external {
        vm.startBroadcast();

        UniversityFacet facet = new UniversityFacet();
        console.log("UniversityFacet desplegado en:", address(facet));

        bytes4[] memory selectors = new bytes4[](7);
        selectors[0] = UniversityFacet.registerProfile.selector;
        selectors[1] = UniversityFacet.updateProfile.selector;
        selectors[2] = UniversityFacet.getProfile.selector;
        selectors[3] = UniversityFacet.listProfiles.selector;
        selectors[4] = UniversityFacet.addUniversityStaff.selector;
        selectors[5] = UniversityFacet.removeUniversityStaff.selector;
        selectors[6] = UniversityFacet.isUniversityStaff.selector;

        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
        cut[0] = IDiamondCut.FacetCut({
            facetAddress: address(facet), action: IDiamondCut.FacetCutAction.Add, functionSelectors: selectors
        });

        DiamondCutFacet(DIAMOND).diamondCut(cut, address(0), "");

        console.log("UniversityFacet agregado al diamond!");
        vm.stopBroadcast();
    }
}
