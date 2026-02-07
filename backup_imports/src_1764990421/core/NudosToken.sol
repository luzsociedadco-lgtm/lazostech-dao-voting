// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NudosToken is ERC20, Ownable {
    address public rewardModule;

    constructor() ERC20("Nudos", "NDS") Ownable(msg.sender) {}

    modifier onlyReward() {
    _checkReward();
    _;
    }

    function _checkReward() internal view {
    require(msg.sender == rewardModule, "Not authorized");
    }


    function setRewardModule(address _module) external onlyOwner {
        rewardModule = _module;
    }

    function mint(address to, uint256 amount) external onlyReward {
        _mint(to, amount);
    }
}
