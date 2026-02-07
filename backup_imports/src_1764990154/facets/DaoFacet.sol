// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





import "../interfaces/modules/IDaoModule.sol" as X;

contract DaoFacet is IDaoModule {
    function createProposal(bytes32 /*kind*/, string calldata /*meta*/) external override returns (bytes32) {
        revert("createProposal: implement");
    }
    function voteProposal(bytes32 /*proposalId*/, bool /*support*/) external override {
        revert("voteProposal: implement");
    }
    function executeProposal(bytes32 /*proposalId*/) external override {
        revert("executeProposal: implement");
    }
}
