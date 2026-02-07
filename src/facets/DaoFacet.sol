// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {AppStorage} from "../libraries/AppStorage.sol";

contract DaoFacet {
    using AppStorage for AppStorage.Layout;

    event AssemblyCreated(uint256 indexed assemblyId, uint256 indexed campusId, string title);
    event ProposalCreated(
        uint256 indexed proposalId,
        uint256 indexed assemblyId,
        address indexed proposer,
        string title
    );
    event Voted(uint256 indexed proposalId, address indexed voter, bool support);
    event ProposalClosed(uint256 indexed proposalId, bool passed);
    event ProposalExecuted(uint256 indexed proposalId);

    // -------------------------
    // Assemblies
    // -------------------------

    function createAssembly(
        uint256 campusId,
        string calldata title,
        string calldata metadata
    ) external returns (uint256 assemblyId) {
        AppStorage.Layout storage s = AppStorage.layout();

        require(
            s.isUniversityStaff[msg.sender] || s.campuses[campusId].isStaff[msg.sender],
            "DaoFacet: not authorized"
        );

        assemblyId = ++s.nextAssemblyId;

        s.assemblies[assemblyId] = AppStorage.Assembly({
            id: assemblyId,
            campusId: campusId,
            title: title,
            metadata: metadata,
            open: true
        });

        emit AssemblyCreated(assemblyId, campusId, title);
    }

    // -------------------------
    // Proposals
    // -------------------------

    function createProposal(
        uint256 assemblyId,
        string calldata title,
        string calldata metadata
    ) external returns (uint256 proposalId) {
        AppStorage.Layout storage s = AppStorage.layout();
        AppStorage.Assembly storage a = s.assemblies[assemblyId];

        require(a.open, "DaoFacet: assembly closed");
        require(
            s.isUniversityStaff[msg.sender] ||
                s.campuses[a.campusId].isStaff[msg.sender],
            "DaoFacet: not authorized"
        );

        proposalId = ++s.nextProposalId;

        s.proposals[proposalId] = AppStorage.Proposal({
            id: proposalId,
            assemblyId: assemblyId,
            proposer: msg.sender,
            title: title,
            metadata: metadata,
            votesFor: 0,
            votesAgainst: 0,
            open: true,
            executed: false
        });

        emit ProposalCreated(proposalId, assemblyId, msg.sender, title);
    }

    // -------------------------
    // Voting
    // -------------------------

    function voteProposal(uint256 proposalId, bool support) external {
        AppStorage.Layout storage s = AppStorage.layout();
        AppStorage.Proposal storage p = s.proposals[proposalId];

        require(p.open, "DaoFacet: proposal closed");

        if (support) {
            p.votesFor += 1;
        } else {
            p.votesAgainst += 1;
        }

        emit Voted(proposalId, msg.sender, support);
    }

    // -------------------------
    // Closing
    // -------------------------

    function closeProposal(uint256 proposalId) external {
        AppStorage.Layout storage s = AppStorage.layout();
        AppStorage.Proposal storage p = s.proposals[proposalId];
        AppStorage.Assembly storage a = s.assemblies[p.assemblyId];

        require(p.open, "DaoFacet: already closed");
        require(
            msg.sender == p.proposer ||
                s.isUniversityStaff[msg.sender] ||
                s.campuses[a.campusId].isStaff[msg.sender],
            "DaoFacet: not authorized"
        );

        p.open = false;

        bool passed = p.votesFor > p.votesAgainst;
        emit ProposalClosed(proposalId, passed);
    }

    // -------------------------
    // Execution
    // -------------------------

    function executeProposal(uint256 proposalId) external {
        AppStorage.Layout storage s = AppStorage.layout();
        AppStorage.Proposal storage p = s.proposals[proposalId];

        require(!p.open, "DaoFacet: proposal still open");
        require(!p.executed, "DaoFacet: already executed");

        p.executed = true;

        emit ProposalExecuted(proposalId);
    }
}
