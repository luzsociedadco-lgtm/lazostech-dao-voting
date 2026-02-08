// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {AppStorage} from "../libraries/AppStorage.sol";

contract RecycleFacet {
    event RecycleRecorded(address indexed user, uint256 timestamp);

    function addRecycleRecord(uint256 aluminium, uint256 plastic, uint256 cardboard, uint256 glass) external {
        AppStorage.Layout storage s = AppStorage.layout();

        AppStorage.MaterialRecord memory record = AppStorage.MaterialRecord({
            aluminium: aluminium, plastic: plastic, cardboard: cardboard, glass: glass, timestamp: block.timestamp
        });

        s.recyclingHistory[msg.sender].push(AppStorage.CampusMaterialRecord({user: msg.sender, record: record}));

        (bool ok,) = address(this)
            .delegatecall(
                abi.encodeWithSignature(
                    "mintReward(address,(uint256,uint256,uint256,uint256,uint256))", msg.sender, record
                )
            );
        require(ok, "Reward mint failed");

        emit RecycleRecorded(msg.sender, block.timestamp);
    }

    function getRecycleHistory(address user) external view returns (AppStorage.CampusMaterialRecord[] memory) {
        return AppStorage.layout().recyclingHistory[user];
    }
}
