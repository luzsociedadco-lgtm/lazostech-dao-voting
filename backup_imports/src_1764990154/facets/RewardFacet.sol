// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "../interfaces/core/INudosToken.sol";
import "../interfaces/modules/IRewardModule.sol";

contract RewardFacet is IRewardModule {

    INudosToken public token;

    // Mapping material → rate
    mapping(bytes32 => uint256) internal _rates;

    event RecycleRateSet(bytes32 indexed material, uint256 rate);
    event RewardMinted(address indexed user, uint256 amount);

    constructor(address _token) {
        token = INudosToken(_token);
    }

    function setRecycleRate(bytes32 material, uint256 rate) external override {
        _rates[material] = rate;
        emit RecycleRateSet(material, rate);
    }

    function calculateRecycleReward(address, MaterialRecord calldata record)
        public view override returns (uint256)
    {
        return (record.aluminium * _rates["AL"]) +
               (record.plastic * _rates["PL"]) +
               (record.glass * _rates["GL"]) +
               (record.cardboard * _rates["CB"]);
    }

    function mintReward(address user, MaterialRecord calldata record) external override {
        uint256 r = calculateRecycleReward(user, record);
        token.mint(user, r);
        emit RewardMinted(user, r);
    }
}
