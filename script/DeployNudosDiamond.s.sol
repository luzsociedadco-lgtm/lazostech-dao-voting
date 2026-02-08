// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {Diamond} from "../src/diamond/Diamond.sol";
import {DiamondCutFacet} from "../src/facets/DiamondCutFacet.sol";
import {DiamondLoupeFacet} from "../src/facets/DiamondLoupeFacet.sol";
import {OwnershipFacet} from "../src/facets/OwnershipFacet.sol";
import {RewardFacet} from "../src/facets/RewardFacet.sol";
import {DiamondInit} from "../src/init/DiamondInit.sol";

import {IDiamondCut} from "../src/interfaces/diamond/IDiamondCut.sol";

contract DeployNudosDiamond is Script {
    function run() external {
        uint256 pk = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(pk);

        // 1. Deploy DiamondCutFacet

        DiamondCutFacet cutFacet = new DiamondCutFacet();
        console.log("DiamondCutFacet deployed at:", address(cutFacet));

        // 2. Deploy Diamond
        address owner = vm.addr(pk);

        Diamond diamond = new Diamond(owner, address(cutFacet));

        console.log("Diamond deployed at:", address(diamond));

        // 3. Deploy Facets
        DiamondLoupeFacet loupeFacet = new DiamondLoupeFacet();
        OwnershipFacet ownershipFacet = new OwnershipFacet();
        RewardFacet rewardFacet = new RewardFacet();
        DiamondInit init = new DiamondInit();

        console.log("LoupeFacet deployed at:", address(loupeFacet));
        console.log("OwnershipFacet deployed at:", address(ownershipFacet));
        console.log("RewardFacet deployed at:", address(rewardFacet));

        // 4. Build FacetCuts
        IDiamondCut.FacetCut[] memory cuts = new IDiamondCut.FacetCut[](3);

        // ---- DiamondLoupeFacet ----
        bytes4[] memory loupeSelectors = new bytes4[](4);
        loupeSelectors[0] = loupeFacet.facets.selector;
        loupeSelectors[1] = loupeFacet.facetFunctionSelectors.selector;
        loupeSelectors[2] = loupeFacet.facetAddresses.selector;
        loupeSelectors[3] = loupeFacet.facetAddress.selector;

        cuts[0] = IDiamondCut.FacetCut({
            facetAddress: address(loupeFacet), action: IDiamondCut.FacetCutAction.Add, functionSelectors: loupeSelectors
        });

        // ---- OwnershipFacet ----
        bytes4[] memory ownershipSelectors = new bytes4[](2);
        ownershipSelectors[0] = ownershipFacet.owner.selector;
        ownershipSelectors[1] = ownershipFacet.transferOwnership.selector;

        cuts[1] = IDiamondCut.FacetCut({
            facetAddress: address(ownershipFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: ownershipSelectors
        });

        // ---- RewardFacet ----
        bytes4[] memory rewardSelectors = new bytes4[](5);
        rewardSelectors[0] = RewardFacet.setRewardToken.selector;
        rewardSelectors[1] = RewardFacet.setRecycleRate.selector;
        rewardSelectors[2] = RewardFacet.grantReward.selector;
        rewardSelectors[3] = RewardFacet.getRewardToken.selector;
        rewardSelectors[4] = RewardFacet.getRecycleRate.selector;

        cuts[2] = IDiamondCut.FacetCut({
            facetAddress: address(rewardFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: rewardSelectors
        });

        // 5. Execute diamondCut
        IDiamondCut(address(diamond)).diamondCut(cuts, address(init), abi.encodeWithSelector(DiamondInit.init.selector));
        console.log("Diamond initialized with all base facets");

        vm.stopBroadcast();
    }
}
