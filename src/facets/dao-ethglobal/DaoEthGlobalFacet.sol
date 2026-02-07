// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {DaoStorage} from "./storage/DaoStorage.sol";

contract DaoEthGlobalFacet {

    // EVENTS
    event ChairpersonSet(address chairperson);
    event BoardMemberAdded(address member);
    event SessionOpened(string name);
    event ResolutionCreated(uint256 id, string description);
    event Voted(address voter, uint256 resolutionId, bool support);

    // MODIFIERS
    modifier onlyChair() {
        DaoStorage.Layout storage ds = DaoStorage.layout();
        require(msg.sender == ds.chairperson, "Not chairperson");
        _;
    }

    modifier onlyBoard() {
        DaoStorage.Layout storage ds = DaoStorage.layout();
        require(ds.boardMembers[msg.sender], "Not board member");
        _;
    }

    // 🔥 INIT (CRITICAL FOR DIAMOND STORAGE)
    function initDao() external {
        DaoStorage.Layout storage ds = DaoStorage.layout();
        require(!ds.initialized, "Already initialized");

        ds.initialized = true;
        ds.sessionActive = false;
    }

    // GOVERNANCE SETUP
    function setChairperson(address _chair) external {
        DaoStorage.Layout storage ds = DaoStorage.layout();
        ds.chairperson = _chair;
        emit ChairpersonSet(_chair);
    }

    function addBoardMember(address member) external onlyChair {
        DaoStorage.Layout storage ds = DaoStorage.layout();
        ds.boardMembers[member] = true;
        emit BoardMemberAdded(member);
    }

    // SESSION MANAGEMENT
    function openSession(string calldata name) external onlyChair {
        DaoStorage.Layout storage ds = DaoStorage.layout();
        require(!ds.sessionActive, "Session already active");

        ds.sessionActive = true;
        emit SessionOpened(name);
    }

    // RESOLUTIONS
    function createResolution(string calldata description) external onlyChair {
        DaoStorage.Layout storage ds = DaoStorage.layout();
        require(ds.sessionActive, "Session not active");

        uint256 id = ds.resolutionCount;
        ds.resolutions[id].description = description;
        ds.resolutionCount++;

        emit ResolutionCreated(id, description);
    }

    // VOTING
    function vote(uint256 resolutionId, bool support) external onlyBoard {
        DaoStorage.Layout storage ds = DaoStorage.layout();
        require(ds.sessionActive, "Session not active");

        DaoStorage.Resolution storage r = ds.resolutions[resolutionId];
        require(!r.voted[msg.sender], "Already voted");

        r.voted[msg.sender] = true;

        if (support) {
            r.yesVotes++;
        } else {
            r.noVotes++;
        }

        emit Voted(msg.sender, resolutionId, support);
    }
}
