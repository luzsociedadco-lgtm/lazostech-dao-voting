// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





interface IDaoModule {
    function createProposal(bytes32 kind, string calldata meta) external returns (bytes32);
    function voteProposal(bytes32 proposalId, bool support) external;
    function executeProposal(bytes32 proposalId) external;
}
