// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {SelectorLib} from "src/diamond/SelectorLib.sol";
import {Diamond} from "src/diamond/Diamond.sol";
import {IDiamondCut} from "src/interfaces/diamond/IDiamondCut.sol";
import {DiamondCutFacet} from "src/facets/core/DiamondCutFacet.sol";
import {DiamondLoupeFacet} from "src/facets/core/DiamondLoupeFacet.sol";
import {OwnershipFacet} from "src/facets/core/OwnershipFacet.sol";
import {DiamondInit} from "src/init/DiamondInit.sol";

// LazosTech facets
import {ParticipationFacet} from "src/facets/economy/ParticipationFacet.sol";
import {RewardFacet} from "src/facets/economy/RewardFacet.sol";
import {TicketsFacet} from "src/facets/economy/TicketsFacet.sol";
import {MarketplaceFacet} from "src/facets/marketplace/MarketplaceFacet.sol";
import {DaoFacet} from "src/facets/governance/DaoFacet.sol";
import {CorporateGovernanceFacet} from "../src/facets/governance/corporate-governance/CorporateGovernanceFacet.sol";
import {CampusFacet} from "src/facets/recycling/CampusFacet.sol";
import {RecycleFacet} from "src/facets/recycling/RecycleFacet.sol";
import {UniversityFacet} from "src/facets/recycling/UniversityFacet.sol";

contract DeployFullDiamond is Script {
    function run() external {
        vm.startBroadcast();

        // 1️⃣ Deploy DiamondCutFacet
        DiamondCutFacet diamondCutFacet = new DiamondCutFacet();

        // 2️⃣ Deploy Diamond
        Diamond diamond = new Diamond(
            msg.sender,
            address(diamondCutFacet)
        );

        // 3️⃣ Deploy Init
        DiamondInit diamondInit = new DiamondInit();

        // 4️⃣ Deploy facets
        DiamondLoupeFacet loupe = new DiamondLoupeFacet();
        OwnershipFacet ownership = new OwnershipFacet();
        ParticipationFacet participation = new ParticipationFacet();
        RewardFacet reward = new RewardFacet();
        TicketsFacet tickets = new TicketsFacet();
        MarketplaceFacet marketplace = new MarketplaceFacet();
        DaoFacet dao = new DaoFacet();
        CorporateGovernanceFacet corporateFacet = new CorporateGovernanceFacet();
        CampusFacet campus = new CampusFacet();
        RecycleFacet recycle = new RecycleFacet();
        UniversityFacet university = new UniversityFacet();

        // 5️⃣ Construir FacetCut array COMPLETO
        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](11);

        cut[0] = IDiamondCut.FacetCut({
            facetAddress: address(loupe),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: SelectorLib.getDiamondLoupeFacetSelectors()
        });

        cut[1] = IDiamondCut.FacetCut({
            facetAddress: address(ownership),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: SelectorLib.getOwnershipFacetSelectors()
        });

        cut[2] = IDiamondCut.FacetCut({
            facetAddress: address(participation),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: SelectorLib.getParticipationFacetSelectors()
        });

        cut[3] = IDiamondCut.FacetCut({
            facetAddress: address(reward),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: SelectorLib.getRewardFacetSelectors()
        });

        cut[4] = IDiamondCut.FacetCut({
            facetAddress: address(tickets),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: SelectorLib.getTicketsFacetSelectors()
        });

        cut[5] = IDiamondCut.FacetCut({
            facetAddress: address(marketplace),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: SelectorLib.getMarketplaceFacetSelectors()
        });

        cut[6] = IDiamondCut.FacetCut({
            facetAddress: address(dao),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: SelectorLib.getDaoFacetSelectors()
        });

        cut[7] = IDiamondCut.FacetCut({
            facetAddress: address(corporateFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: SelectorLib.getCorporateGovernanceFacetSelectors()
        });

        cut[8] = IDiamondCut.FacetCut({
            facetAddress: address(campus),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: SelectorLib.getCampusFacetSelectors()
        });

        cut[9] = IDiamondCut.FacetCut({
            facetAddress: address(recycle),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: SelectorLib.getRecycleFacetSelectors()
        });

        cut[10] = IDiamondCut.FacetCut({
            facetAddress: address(university),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: SelectorLib.getUniversityFacetSelectors()
        });

        // 6️⃣ Ejecutar Diamond Cut con Init
        IDiamondCut(address(diamond)).diamondCut(
            cut,
            address(diamondInit),
            abi.encodeWithSelector(DiamondInit.init.selector)
        );

        vm.stopBroadcast();

        console2.log("DIAMOND DEPLOYED AT:", address(diamond));
    }
}
