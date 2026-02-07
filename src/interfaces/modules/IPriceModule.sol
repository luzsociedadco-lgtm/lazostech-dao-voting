// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

enum Material {
    PET,
    PLASTIC,
    ALUMINUM,
    CARDBOARD,
    GLASS
}

struct PriceHistoryEntry {
    uint256[5] referencePrices;
    uint256 average;
    uint256 timestamp;
}

interface IPriceModule {
    event PricesUpdated(Material indexed material, uint256 average, address indexed updater);

    function setReferencePrices(Material material, uint256[5] calldata prices) external;
    function getReferencePrices(Material material) external pure returns (uint256[5] memory);
    function getAverage(Material material) external pure returns (uint256);
    function getHistoryLength(Material material) external pure returns (uint256);
    function getHistoryEntry(Material material, uint256 index) external pure returns (PriceHistoryEntry memory);
}
