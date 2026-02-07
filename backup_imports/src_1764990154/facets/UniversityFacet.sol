// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





contract UniversityFacet {
    struct ProfileData {
        string name;
        string career;
        uint256 semester;
        bool verified;
    }

    function registerProfile(address /*user*/, ProfileData calldata /*data*/) external {
        revert("registerProfile: implement");
    }

    function isVerified(address /*user*/) external view returns (bool) {
        revert("isVerified: implement");
    }
}
