// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

library UniversityGovernanceStorage {

    bytes32 constant STORAGE_POSITION =
        keccak256("lazostech.storage.university.governance");

    // 👤 Quien ejecutará actividades aprobadas (ej: logística reciclaje)
    struct Executor {
        bool assigned;
        uint256 completedActivities;
        uint256 redeemableRewards;
    }

    struct Resolution {
        string description;
        uint256 yesVotes;
        uint256 noVotes;
        bool closed;

        mapping(address => bool) voted;
        address executor;     // quién ejecuta la actividad
        bool executed;        // si ya se completó
    }

    struct Layout {
        bool initialized;
        bool sessionActive;

        // 👩‍🎓 Asamblea universitaria
        mapping(address => bool) members;

        uint256 resolutionCount;
        mapping(uint256 => Resolution) resolutions;

        mapping(address => Executor) executors;
    }

    function layout() internal pure returns (Layout storage l) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            l.slot := position
        }
    }
}
