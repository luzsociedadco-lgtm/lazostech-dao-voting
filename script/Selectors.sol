// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {CampusFacet} from "../src/facets/CampusFacet.sol";
import {DaoFacet} from "../src/facets/DaoFacet.sol";
import {MarketplaceFacet} from "../src/facets/MarketplaceFacet.sol";
import {ParticipationFacet} from "../src/facets/ParticipationFacet.sol";
import {RecycleFacet} from "../src/facets/RecycleFacet.sol";
import {RewardFacet} from "../src/facets/RewardFacet.sol";
import {TicketsFacet} from "../src/facets/TicketsFacet.sol";
import {UniversityFacet} from "../src/facets/UniversityFacet.sol";
import {DiamondCutFacet} from "../src/facets/DiamondCutFacet.sol";
import {OwnershipFacet} from "../src/facets/OwnershipFacet.sol";
import {IDiamondLoupe} from "../src/interfaces/diamond/IDiamondLoupe.sol";

library Selectors {

    function getDiamondLoupeFacetSelectors() internal pure returns (bytes4[] memory s) {
        s = new bytes4[](4);
        s[0] = IDiamondLoupe.facets.selector;
        s[1] = IDiamondLoupe.facetFunctionSelectors.selector;
        s[2] = IDiamondLoupe.facetAddresses.selector;
        s[3] = IDiamondLoupe.facetAddress.selector;
        return s;
    }

    function getDiamondCutFacetSelectors() internal pure returns (bytes4[] memory s) {
        s = new bytes4[](1);
        s[0] = DiamondCutFacet.diamondCut.selector;
    }

    function getUniversityFacetSelectors() internal pure returns (bytes4[] memory s) {
        s = new bytes4[](6);
        s[0] = UniversityFacet.registerProfile.selector;
        s[1] = UniversityFacet.updateProfile.selector;
        s[2] = UniversityFacet.getProfile.selector;
        s[3] = UniversityFacet.listProfiles.selector;
        s[4] = UniversityFacet.addUniversityStaff.selector;
        s[5] = UniversityFacet.isUniversityStaff.selector;
        return s;
    }

    function getCampusFacetSelectors() internal pure returns (bytes4[] memory s) {
        s = new bytes4[](7);
        s[0] = CampusFacet.createCampus.selector;
        s[1] = CampusFacet.updateCampus.selector;
        s[2] = CampusFacet.addCampusStaff.selector;
        s[3] = CampusFacet.removeCampusStaff.selector;
        s[4] = CampusFacet.isCampusStaff.selector;
        s[5] = CampusFacet.getCampus.selector;
        s[6] = CampusFacet.listCampusIds.selector;
        return s;
    }

    function getTicketsFacetSelectors() internal pure returns (bytes4[] memory s) {
        s = new bytes4[](3);
        s[0] = TicketsFacet.mintTicket.selector;
        s[1] = TicketsFacet.transferTicket.selector;
        s[2] = TicketsFacet.useTicket.selector;
        return s;
    }

    function getRecycleFacetSelectors() public pure returns (bytes4[] memory s) {
        s = new bytes4[](2);
        s[0] = RecycleFacet.addRecycleRecord.selector;
        s[1] = RecycleFacet.getRecycleHistory.selector;
        return s;
    }

    function getMarketplaceFacetSelectors() internal pure returns (bytes4[] memory s) {
        s = new bytes4[](7);
        s[0] = MarketplaceFacet.createItem.selector;
        s[1] = MarketplaceFacet.listItem.selector;
        s[2] = MarketplaceFacet.buyWithTokens.selector;
        s[3] = MarketplaceFacet.proposeTrade.selector;
        s[4] = MarketplaceFacet.acceptTrade.selector;
        s[5] = MarketplaceFacet.rateItem.selector;
        s[6] = MarketplaceFacet.getItem.selector;
        return s;
    }

    function getDaoFacetSelectors() internal pure returns (bytes4[] memory s) {
        s = new bytes4[](5);
        s[0] = DaoFacet.createAssembly.selector;
        s[1] = DaoFacet.createProposal.selector;
        s[2] = DaoFacet.voteProposal.selector;
        s[3] = DaoFacet.closeProposal.selector;
        s[4] = DaoFacet.executeProposal.selector;
        return s;
    }

    function getParticipationFacetSelectors() internal pure returns (bytes4[] memory s) {
        s = new bytes4[](2);
        s[0] = ParticipationFacet.registerSubmission.selector;
        s[1] = ParticipationFacet.validateCompletion.selector;
        return s;
    }

    function getRewardFacetSelectors() internal pure returns (bytes4[] memory s) {
        s = new bytes4[](5);
    s[0] = RewardFacet.setRewardToken.selector;
    s[1] = RewardFacet.setRecycleRate.selector;
    s[2] = RewardFacet.grantReward.selector;
    s[3] = RewardFacet.getRewardToken.selector;
    s[4] = RewardFacet.getRecycleRate.selector;
        return s;
    }

    function getOwnershipFacetSelectors() internal pure returns (bytes4[] memory s) {
        s = new bytes4[](2);
        s[0] = OwnershipFacet.owner.selector;
        s[1] = OwnershipFacet.transferOwnership.selector;
        return s;
    }
}
