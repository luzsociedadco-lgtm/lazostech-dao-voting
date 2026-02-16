// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

library CorporateGovernanceStorage {

    bytes32 constant STORAGE_POSITION =
        keccak256("lazostech.storage.corporate.governance");

    struct Resolution {
        string description;
        uint256 yesVotes;
        uint256 noVotes;
        bool closed;
        mapping(address => bool) voted;
    }

    struct Layout {
        bool initialized;
        bool sessionActive;

        address chairperson;
        mapping(address => bool) boardMembers;

        uint256 resolutionCount;
        mapping(uint256 => Resolution) resolutions;
    }

    function layout() internal pure returns (Layout storage l) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            l.slot := position
        }
    }
}
