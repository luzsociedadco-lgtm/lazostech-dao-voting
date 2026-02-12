// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {Diamond} from "../src/diamond/Diamond.sol";
import {DiamondCutFacet} from "../src/facets/core/DiamondCutFacet.sol";

contract DeployDiamondBasic is Script {
    function run() external {
        uint256 pk = vm.envUint("PRIVATE_KEY");
        address owner = vm.addr(pk);

        vm.startBroadcast(pk);

        DiamondCutFacet diamondCutFacet = new DiamondCutFacet();
        Diamond diamond = new Diamond(owner, address(diamondCutFacet));

        console.log("Diamond deployed at:", address(diamond));
        console.log("DiamondCutFacet at:", address(diamondCutFacet));
        console.log("Owner:", owner);

        vm.stopBroadcast();
    }
}
