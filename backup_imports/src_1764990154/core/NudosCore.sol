// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





contract NudosCore {
    // Registry events
    event ModuleRegistered(bytes32 indexed name, address indexed module);
    event ModuleUnregistered(bytes32 indexed name, address indexed module);

    function registerModule(bytes32 name, address module) external {
        revert("registerModule: implement");
    }

    function unregisterModule(bytes32 name) external {
        revert("unregisterModule: implement");
    }

    function getModule(bytes32 name) external view returns (address) {
        revert("getModule: implement");
    }
}
