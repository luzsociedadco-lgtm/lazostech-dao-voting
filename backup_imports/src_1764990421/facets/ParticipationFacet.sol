// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





contract ParticipationFacet {
    // Tracks submissions / completions for participation rewards
    function registerSubmission(bytes32 /*proposalId*/, address /*actor*/, string calldata /*evidence*/) external {
        revert("registerSubmission: implement");
    }
    function validateCompletion(bytes32 /*proposalId*/, address /*actor*/) external returns (bool) {
        revert("validateCompletion: implement");
    }
}
