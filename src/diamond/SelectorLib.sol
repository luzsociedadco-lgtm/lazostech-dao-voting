// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 🔗 IMPORTAMOS TODOS LOS FACETS (necesario para .selector)
import {DiamondCutFacet} from "src/facets/core/DiamondCutFacet.sol";
import {DiamondLoupeFacet} from "src/facets/core/DiamondLoupeFacet.sol";
import {OwnershipFacet} from "src/facets/core/OwnershipFacet.sol";

import {ParticipationFacet} from "src/facets/economy/ParticipationFacet.sol";
import {RewardFacet} from "src/facets/economy/RewardFacet.sol";
import {TicketsFacet} from "src/facets/economy/TicketsFacet.sol";

import {MarketplaceFacet} from "src/facets/marketplace/MarketplaceFacet.sol";

import {DaoFacet} from "src/facets/governance/DaoFacet.sol";
import {CorporateGovernanceFacet} from "src/facets/governance/corporate-governance/CorporateGovernanceFacet.sol";
import {UniversityGovernanceFacet} from "src/facets/governance/university-governance/UniversityGovernanceFacet.sol";

import {CampusFacet} from "src/facets/recycling/CampusFacet.sol";
import {RecycleFacet} from "src/facets/recycling/RecycleFacet.sol";
import {UniversityFacet} from "src/facets/recycling/UniversityFacet.sol";

library SelectorLib {

function getDiamondCutFacetSelectors() internal pure returns (bytes4[] memory selectors) {
    selectors = new bytes4[](1);
    selectors[0] = DiamondCutFacet.diamondCut.selector;
}

function getDiamondLoupeFacetSelectors() internal pure returns (bytes4[] memory selectors) {
    selectors = new bytes4[](4);
    selectors[0] = DiamondLoupeFacet.facetAddress.selector;
    selectors[1] = DiamondLoupeFacet.facetAddresses.selector;
    selectors[2] = DiamondLoupeFacet.facetFunctionSelectors.selector;
    selectors[3] = DiamondLoupeFacet.facets.selector;
}

function getOwnershipFacetSelectors() internal pure returns (bytes4[] memory selectors) {
    selectors = new bytes4[](2);
    selectors[0] = OwnershipFacet.owner.selector;
    selectors[1] = OwnershipFacet.transferOwnership.selector;
}

function getParticipationFacetSelectors() internal pure returns (bytes4[] memory selectors) {
    selectors = new bytes4[](2);
    selectors[0] = ParticipationFacet.registerSubmission.selector;
    selectors[1] = ParticipationFacet.validateCompletion.selector;
}

function getRewardFacetSelectors() internal pure returns (bytes4[] memory selectors) {
    selectors = new bytes4[](7);
    selectors[0] = RewardFacet.getNudos.selector;
    selectors[1] = RewardFacet.getNudosAccumulated.selector;
    selectors[2] = RewardFacet.getRecycleRate.selector;
    selectors[3] = RewardFacet.getRewardToken.selector;
    selectors[4] = RewardFacet.grantReward.selector;
    selectors[5] = RewardFacet.setRecycleRate.selector;
    selectors[6] = RewardFacet.setRewardToken.selector;
}

function getTicketsFacetSelectors() internal pure returns (bytes4[] memory selectors) {
    selectors = new bytes4[](5);
    selectors[0] = TicketsFacet.getTickets.selector;
    selectors[1] = TicketsFacet.mintTicket.selector;
    selectors[2] = TicketsFacet.redeemTickets.selector;
    selectors[3] = TicketsFacet.transferTicket.selector;
    selectors[4] = TicketsFacet.useTicket.selector;
}

function getDaoFacetSelectors() internal pure returns (bytes4[] memory selectors) {
    selectors = new bytes4[](5);
    selectors[0] = DaoFacet.closeProposal.selector;
    selectors[1] = DaoFacet.createAssembly.selector;
    selectors[2] = DaoFacet.createProposal.selector;
    selectors[3] = DaoFacet.executeProposal.selector;
    selectors[4] = DaoFacet.voteProposal.selector;
}

function getMarketplaceFacetSelectors() internal pure returns (bytes4[] memory selectors) {
    selectors = new bytes4[](7);
    selectors[0] = MarketplaceFacet.acceptTrade.selector;
    selectors[1] = MarketplaceFacet.buyWithTokens.selector;
    selectors[2] = MarketplaceFacet.createItem.selector;
    selectors[3] = MarketplaceFacet.getItem.selector;
    selectors[4] = MarketplaceFacet.listItem.selector;
    selectors[5] = MarketplaceFacet.proposeTrade.selector;
    selectors[6] = MarketplaceFacet.rateItem.selector;
}

function getCampusFacetSelectors() internal pure returns (bytes4[] memory selectors) {
    selectors = new bytes4[](7);
    selectors[0] = CampusFacet.addCampusStaff.selector;
    selectors[1] = CampusFacet.createCampus.selector;
    selectors[2] = CampusFacet.getCampus.selector;
    selectors[3] = CampusFacet.isCampusStaff.selector;
    selectors[4] = CampusFacet.listCampusIds.selector;
    selectors[5] = CampusFacet.removeCampusStaff.selector;
    selectors[6] = CampusFacet.updateCampus.selector;
}

function getRecycleFacetSelectors() internal pure returns (bytes4[] memory selectors) {
    selectors = new bytes4[](2);
    selectors[0] = RecycleFacet.addRecycleRecord.selector;
    selectors[1] = RecycleFacet.getRecycleHistory.selector;
}

function getUniversityFacetSelectors() internal pure returns (bytes4[] memory selectors) {
    selectors = new bytes4[](7);
    selectors[0] = UniversityFacet.addUniversityStaff.selector;
    selectors[1] = UniversityFacet.getProfile.selector;
    selectors[2] = UniversityFacet.isUniversityStaff.selector;
    selectors[3] = UniversityFacet.listProfiles.selector;
    selectors[4] = UniversityFacet.registerProfile.selector;
    selectors[5] = UniversityFacet.removeUniversityStaff.selector;
    selectors[6] = UniversityFacet.updateProfile.selector;
}

function getCorporateGovernanceFacetSelectors()
    internal
    pure
    returns (bytes4[] memory selectors)
{
    selectors = new bytes4[](7);

    selectors[0] = CorporateGovernanceFacet.initDao.selector;
    selectors[1] = CorporateGovernanceFacet.setChairperson.selector;
    selectors[2] = CorporateGovernanceFacet.addBoardMember.selector;
    selectors[3] = CorporateGovernanceFacet.openSession.selector;
    selectors[4] = CorporateGovernanceFacet.createResolution.selector;
    selectors[5] = CorporateGovernanceFacet.vote.selector;
    selectors[6] = CorporateGovernanceFacet.closeResolution.selector;
}

function getUniversityGovernanceFacetSelectors()
    internal
    pure
    returns (bytes4[] memory selectors)
{
    selectors = new bytes4[](8);

    selectors[0] = UniversityGovernanceFacet.addMember.selector;
    selectors[1] = UniversityGovernanceFacet.openUniversitySession.selector;
    selectors[2] = UniversityGovernanceFacet.createUniversityResolution.selector;
    selectors[3] = UniversityGovernanceFacet.voteUniversity.selector;
    selectors[4] = UniversityGovernanceFacet.closeUniversityResolution.selector;
    selectors[5] = UniversityGovernanceFacet.assignExecutor.selector;
    selectors[6] = UniversityGovernanceFacet.markActivityCompleted.selector;
    selectors[7] = UniversityGovernanceFacet.redeemIncentive.selector;
}

}
