// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {AppStorage} from "../libraries/AppStorage.sol";

contract DiamondInit {
    function init() external {
        AppStorage.Layout storage s = AppStorage.layout();

        // === CONFIG ECONÓMICA BASE ===
        s.nudosPerTicket = 10;
    }
}
