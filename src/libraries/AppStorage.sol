// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

library AppStorage {
    // =============================================================
    // STORAGE SLOT (ÚNICO)
    // =============================================================
    bytes32 internal constant STORAGE_SLOT = keccak256("nudos.app.storage.v1");

    // =============================================================
    // ENUMS
    // =============================================================
    enum Role {
        None,
        Student,
        Professor,
        CampusStaff,
        UniversityStaff
    }

    enum ItemStatus {
        Unlisted,
        Listed,
        Sold
    }

    enum Material {
        AL,
        PL,
        CB,
        GL,
        OT
    }

    // =============================================================
    // STRUCTS AUXILIARES
    // =============================================================

    // ---- Campus ----
    struct Campus {
        uint256 id;
        string name;
        string metadataURI;
        address[] staffList;
        mapping(address => bool) isStaff;
    }

    // ---- Profiles ----
    struct Profile {
        address owner;
        string metadataURI;
        uint256 universityId;
        Role role;
        bool exists;
    }

    // ---- Marketplace ----
    struct Item {
        uint256 id;
        address owner;
        uint8 itemType;
        string metadataURI;
        uint256 price;
        ItemStatus status;
    }

    struct Trade {
        uint256 id;
        address proposer;
        uint256 itemA;
        uint256 itemB;
        bool accepted;
    }

    // ---- DAO ----
    struct Assembly {
        uint256 id;
        uint256 campusId;
        string title;
        string metadata;
        bool open;
    }

    struct Proposal {
        uint256 id;
        uint256 assemblyId;
        address proposer;
        string title;
        string metadata;
        uint256 votesFor;
        uint256 votesAgainst;
        bool open;
        bool executed;
    }

    // ---- Participation ----
    struct ParticipationData {
        bool submitted;
        bool validated;
        string evidence;
    }

    // ---- Recycling ----
    struct MaterialRecord {
        uint256 aluminium;
        uint256 plastic;
        uint256 cardboard;
        uint256 glass;
        uint256 timestamp;
    }

    struct CampusMaterialRecord {
        address user;
        MaterialRecord record;
    }

    // =============================================================
    // LAYOUT PRINCIPAL (ÚNICO)
    // =============================================================
    struct Layout {
        // ---- Ownership ----
        address owner;

        // ---- Campuses ----
        mapping(uint256 => Campus) campuses;
        uint256[] campusIds;

        // ---- Profiles ----
        mapping(address => Profile) profiles;
        address[] profileOwners;

        // ---- University Staff ----
        mapping(address => bool) isUniversityStaff;

        // ---- Tickets ----
        mapping(address => uint256) ticketBalance;
        address tokenContract;
        uint256 ticketPriceInTokens;

        // ---- Rewards ----
        address token;
        mapping(bytes32 => uint256) recycleRates;

        // ---- NUDOS Economy ----
        mapping(address => uint256) nudosBalance; // tokens disponibles
        mapping(address => uint256) nudosAccumulated; // histórico total
        uint256 nudosPerTicket; // = 10

        // ---- Marketplace ----
        uint256 nextItemId;
        uint256 nextTradeId;
        uint256 marketplaceFeeBps;
        mapping(uint256 => Item) items;
        mapping(uint256 => Trade) trades;
        mapping(uint256 => mapping(address => uint8)) ratings;

        // ---- DAO ----
        uint256 nextAssemblyId;
        uint256 nextProposalId;
        mapping(uint256 => Assembly) assemblies;
        mapping(uint256 => Proposal) proposals;

        // ---- Participation ----
        mapping(bytes32 => mapping(address => ParticipationData)) participation;

        // ---- Recycling History ----
        mapping(address => CampusMaterialRecord[]) recyclingHistory;
    }

    // =============================================================
    // ACCESSOR
    // =============================================================
    function layout() internal pure returns (Layout storage s) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            s.slot := slot
        }
    }
}
