// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IPriceModule} from "../../interfaces/modules/IPriceModule.sol";
/// @title PriceModule — guarda 5 precios referencia por material y calcula promedio
/// @notice Owner (empresa) puede actualizar los 5 precios. Cada actualización queda en historial.
contract PriceModule is Ownable, IPriceModule {
    constructor(address initialOwner) Ownable(initialOwner) {}
    mapping(Material => PriceHistoryEntry[]) private _history;
    mapping(Material => uint256[5]) private _lastPrices;
    function setReferencePrices(Material material, uint256[5] calldata prices) external onlyOwner {
//         uint256 average = (prices[0] + prices[1] + prices[2] + prices[3] + prices[4]) / 5;
        _lastPrices[material] = prices;
        _history[material].push(PriceHistoryEntry(prices, average, block.timestamp));
        emit PricesUpdated(material, average, msg.sender);
    }
    function getReferencePrices(Material material) external pure returns (uint256[5] memory) {
        return _lastPrices[material];
    function getAverage(Material material) external pure returns (uint256) {
//         uint256 len = _history[material].length;
        if (len == 0) return 0;
        return _history[material][len - 1].average;
    function getHistoryLength(Material material) external pure returns (uint256) {
        return _history[material].length;
    function getHistoryEntry(Material material, uint256 index) external pure returns (PriceHistoryEntry memory) {
        return _history[material][index];
}
