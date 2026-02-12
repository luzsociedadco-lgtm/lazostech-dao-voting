// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {AppStorage} from "../../libraries/AppStorage.sol";

contract RewardFacet {
    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/
    modifier onlyOwner() {
        _onlyOwner();
        _;
    }

    function _onlyOwner() internal view {
        require(msg.sender == AppStorage.layout().owner, "RewardFacet: NOT_OWNER");
    }

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/
    event RewardGranted(address indexed user, uint256 amount);
    event TokenUpdated(address indexed token);
    event RecycleRateUpdated(bytes32 indexed material, uint256 rate);

    /*//////////////////////////////////////////////////////////////
                                ADMIN
    //////////////////////////////////////////////////////////////*/
    function setRewardToken(address token) external onlyOwner {
        require(token != address(0), "RewardFacet: ZERO_ADDRESS");
        AppStorage.layout().token = token;
        emit TokenUpdated(token);
    }

    function setRecycleRate(bytes32 material, uint256 rate) external onlyOwner {
        require(rate > 0, "RewardFacet: ZERO_RATE");
        AppStorage.layout().recycleRates[material] = rate;
        emit RecycleRateUpdated(material, rate);
    }

    /*//////////////////////////////////////////////////////////////
                                REWARDS
    //////////////////////////////////////////////////////////////*/
    function grantReward(address user, uint256 amount) external onlyOwner {
        require(user != address(0), "RewardFacet: ZERO_USER");
        require(amount > 0, "RewardFacet: ZERO_AMOUNT");

        AppStorage.Layout storage s = AppStorage.layout();
        s.nudosBalance[user] += amount;
        s.nudosAccumulated[user] += amount;

        emit RewardGranted(user, amount);
    }

    /*//////////////////////////////////////////////////////////////
                                VIEWS
    //////////////////////////////////////////////////////////////*/
    function getRewardToken() external view returns (address) {
        return AppStorage.layout().token;
    }

    function getRecycleRate(bytes32 material) external view returns (uint256) {
        return AppStorage.layout().recycleRates[material];
    }

    function getNudos(address user) external view returns (uint256) {
        return AppStorage.layout().nudosBalance[user];
    }

    function getNudosAccumulated(address user) external view returns (uint256) {
        return AppStorage.layout().nudosAccumulated[user];
    }
}
