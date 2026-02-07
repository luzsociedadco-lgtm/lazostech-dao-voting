// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {NudosToken} from "../../core/NudosToken.sol";
contract ReciclajeModule {
    NudosToken public token;
    constructor(address tokenAddress) {
        token = NudosToken(tokenAddress);
    }
    function rewardReciclaje(address usuario, uint256 puntos) public {
        token.mint(usuario, puntos);
}
