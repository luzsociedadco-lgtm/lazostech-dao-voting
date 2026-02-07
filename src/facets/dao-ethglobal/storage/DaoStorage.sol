// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library DaoStorage {

    bytes32 constant STORAGE_POSITION = keccak256("lazostech.dao.ethglobal.storage");

    struct Resolution {
        string description;
        uint256 yesVotes;
        uint256 noVotes;
        bool executed;
        mapping(address => bool) voted;
    }

    struct Layout {
        // governance
        address chairperson;
        bool initialized;
        bool sessionActive;

        // board
        mapping(address => bool) boardMembers;

        // voting
        uint256 resolutionCount;
        mapping(uint256 => Resolution) resolutions;
    }

    function layout() internal pure returns (Layout storage ds) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
