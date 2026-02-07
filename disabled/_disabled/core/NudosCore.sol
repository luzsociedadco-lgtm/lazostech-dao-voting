// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract NudosCore is Ownable {
    mapping(bytes32 => address) public modules;

    event ModuleSet(bytes32 indexed name, address indexed module);

    function setModule(bytes32 name, address module) external onlyOwner {
        modules[name] = module;
        emit ModuleSet(name, module);
    }

    function getModule(bytes32 name) external view returns (address) {
        return modules[name];
    }
}
