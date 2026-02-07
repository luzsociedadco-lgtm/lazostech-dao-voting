// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





contract CampusFacet {
    function createCampus(bytes32 /*campusId*/, string calldata /*meta*/) external {
        revert("createCampus: implement");
    }
    function getCampus(bytes32 /*campusId*/) external view returns (address) {
        revert("getCampus: implement");
    }
}
