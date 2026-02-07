// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../../src/facets/dao-ethglobal/DaoEthGlobalFacet.sol";

contract DeployDao is Script {
    function run() external {
        vm.startBroadcast();

        DaoEthGlobalFacet dao = new DaoEthGlobalFacet();

        vm.stopBroadcast();
    }
}
