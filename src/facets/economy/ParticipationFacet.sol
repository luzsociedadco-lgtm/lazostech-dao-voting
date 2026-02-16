// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {AppStorage} from "src/libraries/AppStorage.sol";

contract ParticipationFacet {
    event SubmissionRegistered(bytes32 indexed proposalId, address indexed actor, string evidence);
    event CompletionValidated(bytes32 indexed proposalId, address indexed actor);

    function registerSubmission(bytes32 proposalId, address actor, string calldata evidence) external {
        AppStorage.Layout storage s = AppStorage.layout();

        s.participation[proposalId][actor].submitted = true;
        s.participation[proposalId][actor].evidence = evidence;

        emit SubmissionRegistered(proposalId, actor, evidence);
    }

    function validateCompletion(bytes32 proposalId, address actor) external returns (bool) {
        AppStorage.Layout storage s = AppStorage.layout();

        require(s.participation[proposalId][actor].submitted, "Not submitted");

        s.participation[proposalId][actor].validated = true;

        emit CompletionValidated(proposalId, actor);
        return true;
    }
}
