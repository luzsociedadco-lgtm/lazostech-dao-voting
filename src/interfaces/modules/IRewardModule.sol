// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {AppStorage} from "../../../libraries/AppStorage.sol";

interface IRewardModule {
    function mintReward(address account, AppStorage.MaterialRecord memory record) external;
    function setRecycleRate(bytes32 material, uint256 rate) external;
    function calculateRecycleReward(address user, AppStorage.MaterialRecord calldata record)
        external
        view
        returns (uint256);
}
