// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {UniversityGovernanceStorage}
from "./storage/UniversityGovernanceStorage.sol";

contract UniversityGovernanceFacet {

    function us()
        internal
        pure
        returns (UniversityGovernanceStorage.Layout storage)
    {
        return UniversityGovernanceStorage.layout();
    }

    // EVENTS
    event MemberAdded(address member);
    event SessionOpened();
    event ResolutionCreated(uint256 id, string description);
    event Voted(address voter, uint256 resolutionId, bool support);
    event ResolutionClosed(uint256 id, bool approved);
    event ExecutorAssigned(uint256 id, address executor);
    event ActivityCompleted(uint256 id, address executor);
    event IncentiveRedeemed(address executor, uint256 amount);

    // ================================
    // 👩‍🎓 MEMBERSHIP
    // ================================

    function addMember(address member) external {
        us().members[member] = true;
        emit MemberAdded(member);
    }

    modifier onlyMember() {
        require(us().members[msg.sender], "Not assembly member");
        _;
    }

    // ================================
    // 🗳 SESSION
    // ================================

    function openUniversitySession() external {
        UniversityGovernanceStorage.Layout storage s = us();
        require(!s.sessionActive, "Session already active");

        s.sessionActive = true;
        emit SessionOpened();
    }

    // ================================
    // 📜 RESOLUTIONS
    // ================================

    function createUniversityResolution(string calldata description) external {
        UniversityGovernanceStorage.Layout storage s = us();
        require(s.sessionActive, "Session not active");

        uint256 id = s.resolutionCount;
        s.resolutions[id].description = description;
        s.resolutionCount++;

        emit ResolutionCreated(id, description);
    }

    function voteUniversity(uint256 resolutionId, bool support)
        external
        onlyMember
    {
        UniversityGovernanceStorage.Layout storage s = us();
        require(s.sessionActive, "Session not active");

        UniversityGovernanceStorage.Resolution storage r =
            s.resolutions[resolutionId];

        require(!r.voted[msg.sender], "Already voted");

        r.voted[msg.sender] = true;

        if (support) r.yesVotes++;
        else r.noVotes++;

        emit Voted(msg.sender, resolutionId, support);
    }

    function closeUniversityResolution(uint256 id) external {
        UniversityGovernanceStorage.Resolution storage r =
            us().resolutions[id];

        require(!r.closed, "Already closed");
        r.closed = true;

        bool approved = r.yesVotes > r.noVotes;
        emit ResolutionClosed(id, approved);
    }

    // ================================
    // 🧑‍🔧 EXECUTION FLOW (LazosTech magic)
    // ================================

    function assignExecutor(uint256 id, address executor) external {
        UniversityGovernanceStorage.Layout storage s = us();
        UniversityGovernanceStorage.Resolution storage r =
            s.resolutions[id];

        require(r.closed, "Resolution not closed");

        r.executor = executor;
        s.executors[executor].assigned = true;

        emit ExecutorAssigned(id, executor);
    }

    function markActivityCompleted(uint256 id) external {
        UniversityGovernanceStorage.Layout storage s = us();
        UniversityGovernanceStorage.Resolution storage r =
            s.resolutions[id];

        require(msg.sender == r.executor, "Not executor");
        require(!r.executed, "Already executed");

        r.executed = true;

        s.executors[msg.sender].completedActivities++;
        s.executors[msg.sender].redeemableRewards += 10 ether;

        emit ActivityCompleted(id, msg.sender);
    }

    function redeemIncentive() external {
        UniversityGovernanceStorage.Executor storage ex =
            us().executors[msg.sender];

        uint256 reward = ex.redeemableRewards;
        require(reward > 0, "No rewards");

        ex.redeemableRewards = 0;

        emit IncentiveRedeemed(msg.sender, reward);
    }
}
