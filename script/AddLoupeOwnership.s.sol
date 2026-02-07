// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {IDiamondCut} from "../src/interfaces/diamond/IDiamondCut.sol";
import {DiamondLoupeFacet} from "../src/facets/DiamondLoupeFacet.sol";
import {OwnershipFacet} from "../src/facets/OwnershipFacet.sol";

contract AddLoupeOwnership is Script {
    address constant DIAMOND = 0x75A80f6662074BD3C789921C3B36AA0e01e62Eb1;

    function run() external {
        uint256 pk = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(pk);

        DiamondLoupeFacet loupe = new DiamondLoupeFacet();
        OwnershipFacet ownership = new OwnershipFacet();

        console.log("Loupe deployed at:", address(loupe));
        console.log("Ownership deployed at:", address(ownership));

        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](2);

        bytes4[] memory loupeSelectors = new bytes4[](4);
        loupeSelectors[0] = 0x48e2b093; // facets()
        loupeSelectors[1] = 0x52ef6b2c; // facetAddresses()
        loupeSelectors[2] = 0xcdffacc6; // facetFunctionSelectors(address)
        loupeSelectors[3] = 0x7a0ed627; // facetAddress(bytes4)

        bytes4[] memory ownSelectors = new bytes4[](2);
        ownSelectors[0] = 0x8da5cb5b; // owner()
        ownSelectors[1] = 0xf2fde38b; // transferOwnership(address)

        cut[0] = IDiamondCut.FacetCut({
            facetAddress: address(loupe),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: loupeSelectors
        });

        cut[1] = IDiamondCut.FacetCut({
            facetAddress: address(ownership),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: ownSelectors
        });

        // El call al diamond (fallback redirige al CutFacet)
        IDiamondCut(DIAMOND).diamondCut(cut, address(0), "");

        console.log("Loupe y Ownership agregados exitosamente!");
        console.log("Diamond listo al 100% en:", DIAMOND);

        vm.stopBroadcast();
    }
}
