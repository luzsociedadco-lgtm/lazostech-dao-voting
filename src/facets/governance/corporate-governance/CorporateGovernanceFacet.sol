// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {CorporateGovernanceStorage} 
from "./storage/CorporateGovernanceStorage.sol";

contract CorporateGovernanceFacet {
function gs() internal pure returns (CorporateGovernanceStorage.Layout storage) {
    return CorporateGovernanceStorage.layout();
}

    // EVENTS
    event ChairpersonSet(address chairperson);
    event BoardMemberAdded(address member);
    event SessionOpened(string name);
    event ResolutionCreated(uint256 id, string description);
    event Voted(address voter, uint256 resolutionId, bool support);

    // MODIFIERS
modifier onlyChair() {
    _onlyChair();
    _;
}

function _onlyChair() internal view {
    CorporateGovernanceStorage.Layout storage ds = CorporateGovernanceStorage.layout();
    require(msg.sender == ds.chairperson, "Not chairperson");
}

modifier onlyBoard() {
    _onlyBoard();
    _;
}

function _onlyBoard() internal view {
    CorporateGovernanceStorage.Layout storage ds = CorporateGovernanceStorage.layout();
    require(ds.boardMembers[msg.sender], "Not board member");
}

    // 🔥 INIT (CRITICAL FOR DIAMOND STORAGE)
    function initDao() external {
        CorporateGovernanceStorage.Layout storage ds = CorporateGovernanceStorage.layout();
        require(!ds.initialized, "Already initialized");

        ds.initialized = true;
        ds.sessionActive = false;
    }

    // GOVERNANCE SETUP
    function setChairperson(address _chair) external {
        CorporateGovernanceStorage.Layout storage ds = CorporateGovernanceStorage.layout();
        ds.chairperson = _chair;
        emit ChairpersonSet(_chair);
    }

    function addBoardMember(address member) external onlyChair {
        CorporateGovernanceStorage.Layout storage ds = CorporateGovernanceStorage.layout();
        ds.boardMembers[member] = true;
        emit BoardMemberAdded(member);
    }

    // SESSION MANAGEMENT
    function openSession(string calldata name) external onlyChair {
        CorporateGovernanceStorage.Layout storage ds = CorporateGovernanceStorage.layout();
        require(!ds.sessionActive, "Session already active");

        ds.sessionActive = true;
        emit SessionOpened(name);
    }

    // RESOLUTIONS
    function createResolution(string calldata description) external onlyChair {
        CorporateGovernanceStorage.Layout storage ds = CorporateGovernanceStorage.layout();
        require(ds.sessionActive, "Session not active");

        uint256 id = ds.resolutionCount;
        ds.resolutions[id].description = description;
        ds.resolutionCount++;

        emit ResolutionCreated(id, description);
    }

    // VOTING
    function vote(uint256 resolutionId, bool support) external onlyBoard {
        CorporateGovernanceStorage.Layout storage ds = CorporateGovernanceStorage.layout();
        require(ds.sessionActive, "Session not active");

        CorporateGovernanceStorage.Resolution storage r = ds.resolutions[resolutionId];
        require(!r.voted[msg.sender], "Already voted");

        r.voted[msg.sender] = true;

        if (support) {
            r.yesVotes++;
        } else {
            r.noVotes++;
        }

        emit Voted(msg.sender, resolutionId, support);
    }

event ResolutionClosed(uint256 id, bool approved, uint256 yesVotes, uint256 noVotes);

function closeResolution(uint256 resolutionId) external onlyChair {
    CorporateGovernanceStorage.Layout storage ds = CorporateGovernanceStorage.layout();
    require(ds.sessionActive, "Session not active");

    CorporateGovernanceStorage.Resolution storage r = ds.resolutions[resolutionId];
    require(!r.closed, "Already closed");

    r.closed = true;

    bool approved = r.yesVotes > r.noVotes;

    emit ResolutionClosed(resolutionId, approved, r.yesVotes, r.noVotes);
}


}
