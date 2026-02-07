// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

library TicketsStorage {
    bytes32 internal constant STORAGE_SLOT = keccak256("lazos.storage.tickets");

    struct Layout {
        mapping(address => uint256) tickets; // Tickets por usuario
        mapping(address => bool) admins; // Quienes pueden mintear
    }

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            l.slot := slot
        }
    }
}
