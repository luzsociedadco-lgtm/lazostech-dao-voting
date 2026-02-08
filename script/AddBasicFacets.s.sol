// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {IDiamondCut} from "../src/interfaces/diamond/IDiamondCut.sol";
import {DiamondCutFacet} from "../src/facets/DiamondCutFacet.sol";
import {DiamondLoupeFacet} from "../src/facets/DiamondLoupeFacet.sol";
import {OwnershipFacet} from "../src/facets/OwnershipFacet.sol"; // ajusta si el nombre es diferente

contract AddBasicFacets is Script {
    address constant DIAMOND = 0xF7A32c99401EdEFf07B86B4E0525da6a90664d3e;

    function run() external {
        uint256 pk = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(pk);

        // Desplegamos nuevos facets básicos
        DiamondCutFacet cutFacet = new DiamondCutFacet();
        DiamondLoupeFacet loupeFacet = new DiamondLoupeFacet();
        OwnershipFacet ownershipFacet = new OwnershipFacet();

        console.log("DiamondCutFacet deployed at:", address(cutFacet));
        console.log("DiamondLoupeFacet deployed at:", address(loupeFacet));
        console.log("OwnershipFacet deployed at:", address(ownershipFacet));

        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](3);

        // DiamondCutFacet - solo diamondCut
        bytes4[] memory cutSelectors = new bytes4[](1);
        cutSelectors[0] = 0x1f931c1c;

        // DiamondLoupeFacet - solo facets() (el único que tenías en inspect)
        // Si tienes más, las agregamos después
        bytes4[] memory loupeSelectors = new bytes4[](1);
        loupeSelectors[0] = 0x7a0ed627; // facets()

        // OwnershipFacet - las estándar
        bytes4[] memory ownSelectors = new bytes4[](2);
        ownSelectors[0] = 0x8da5cb5b; // owner()
        ownSelectors[1] = 0xf2fde38b; // transferOwnership(address)

        cut[0] = IDiamondCut.FacetCut({
            facetAddress: address(cutFacet), action: IDiamondCut.FacetCutAction.Add, functionSelectors: cutSelectors
        });

        cut[1] = IDiamondCut.FacetCut({
            facetAddress: address(loupeFacet), action: IDiamondCut.FacetCutAction.Add, functionSelectors: loupeSelectors
        });

        cut[2] = IDiamondCut.FacetCut({
            facetAddress: address(ownershipFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: ownSelectors
        });

        // Ejecutamos el cut
        DiamondCutFacet(DIAMOND).diamondCut(cut, address(0), "");

        console.log("Basic facets added successfully to the diamond!");
        vm.stopBroadcast();
    }
}
