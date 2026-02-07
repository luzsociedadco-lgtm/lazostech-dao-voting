// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





contract MarketplaceFacet {
    function createListing(/* params */) external returns (uint256) {
        revert("createListing: implement");
    }
    function buyListing(uint256 /*id*/) external payable {
        revert("buyListing: implement");
    }
}
