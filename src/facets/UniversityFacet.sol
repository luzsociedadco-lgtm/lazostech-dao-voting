// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {AppStorage} from "../libraries/AppStorage.sol";

contract UniversityFacet {
    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/
    event ProfileRegistered(address indexed owner, uint256 universityId, uint8 role);
    event ProfileUpdated(address indexed owner);
    event UniversityStaffAdded(address indexed staff);
    event UniversityStaffRemoved(address indexed staff);

    /*//////////////////////////////////////////////////////////////
                               MODIFIERS
    //////////////////////////////////////////////////////////////*/
    modifier onlyUniversityStaff() {
        _checkUniversityStaff();
        _;
    }

    function _checkUniversityStaff() internal view {
        AppStorage.Layout storage s = AppStorage.layout();
        require(s.isUniversityStaff[msg.sender], "UniversityFacet: not university staff");
    }

    /*//////////////////////////////////////////////////////////////
                           PROFILE MANAGEMENT
    //////////////////////////////////////////////////////////////*/
    function registerProfile(string calldata metadataURI, uint256 universityId, uint8 role) external {
        address owner = msg.sender; // Solo uno mismo puede registrarse
        AppStorage.Layout storage s = AppStorage.layout();
        AppStorage.Profile storage p = s.profiles[owner];

        require(!p.exists, "Profile already exists");

        p.owner = owner;
        p.metadataURI = metadataURI;
        p.universityId = universityId;
        p.role = AppStorage.Role(role);
        p.exists = true;

        s.profileOwners.push(owner);

        emit ProfileRegistered(owner, universityId, role);
    }

    function updateProfile(string calldata metadataURI) external {
        address owner = msg.sender;
        AppStorage.Layout storage s = AppStorage.layout();
        AppStorage.Profile storage p = s.profiles[owner];

        require(p.exists, "Profile not found");
        // El owner o staff puede actualizar
        require(msg.sender == owner || s.isUniversityStaff[msg.sender], "Not allowed");

        p.metadataURI = metadataURI;
        emit ProfileUpdated(owner);
    }

    function getProfile(address owner) external view returns (address, string memory, uint256, uint8) {
        AppStorage.Layout storage s = AppStorage.layout();
        AppStorage.Profile storage p = s.profiles[owner];
        require(p.exists, "Profile not found");

        return (p.owner, p.metadataURI, p.universityId, uint8(p.role));
    }

    function listProfiles() external view returns (address[] memory) {
        AppStorage.Layout storage s = AppStorage.layout();
        return s.profileOwners;
    }

    /*//////////////////////////////////////////////////////////////
                       UNIVERSITY STAFF MANAGEMENT
    //////////////////////////////////////////////////////////////*/
    function addUniversityStaff(address staff) external onlyUniversityStaff {
        AppStorage.Layout storage s = AppStorage.layout();
        if (!s.isUniversityStaff[staff]) {
            s.isUniversityStaff[staff] = true;
            emit UniversityStaffAdded(staff);
        }
    }

    function removeUniversityStaff(address staff) external onlyUniversityStaff {
        AppStorage.Layout storage s = AppStorage.layout();
        if (s.isUniversityStaff[staff]) {
            s.isUniversityStaff[staff] = false;
            emit UniversityStaffRemoved(staff);
        }
    }

    function isUniversityStaff(address who) external view returns (bool) {
        AppStorage.Layout storage s = AppStorage.layout();
        return s.isUniversityStaff[who];
    }
}
