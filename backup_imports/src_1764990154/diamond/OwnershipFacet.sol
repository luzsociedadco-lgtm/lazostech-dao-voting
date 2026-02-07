// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





/// @notice OwnershipFacet skeleton for diamond ownership management
contract OwnershipFacet {
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function owner() external view returns (address) {
        revert("owner: implement");
    }

    function transferOwnership(address newOwner) external {
        revert("transferOwnership: implement");
    }
}
